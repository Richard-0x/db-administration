USE DB_Ecobici_CDMX;

DELIMITER $$
CREATE EVENT ev_mantenimiento_semanal
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
COMMENT 'ANALYZE semanal y OPTIMIZE mensual (primer sabado)'
DO
BEGIN
    ANALYZE TABLE viajes, historico_viajes;
    IF DAYOFMONTH(CURRENT_DATE) <= 7 THEN
        OPTIMIZE TABLE viajes;
    END IF;
END$$
DELIMITER ;

SELECT event_name, status, last_executed FROM information_schema.events WHERE event_schema = 'DB_Ecobici_CDMX';