/*------------------------------------------------------------------------------------------------------------------------------------------------
   Para que el script se ejecute de una sola pasada, por favor asegúrese 
   de colocar los 18 archivos CSV en la ruta segura de su servidor MySQL:
   C:/ProgramData/MySQL/MySQL Server X.X/Uploads/
   
   https://drive.google.com/drive/folders/1ogxHLMOxqbDtDr0JjjXlNfBxNryxPC8Q?usp=sharing
------------------------------------------------------------------------------------------------------------------------------------------------ */
-- Query Teach Solitións.
-- Movilidad: Ecobici CDMX.
-- -----------------------------------------------------TEAM 6-----------------------------------------------------------------------------------
-- Estrada Romero Meliza Edith
-- López Ramírez Ricardo
-- Ruiz Sánchez Emiliano
-- Cabrera Trejo José Luis
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS DB_Ecobici_CDMX;
USE DB_Ecobici_CDMX;

-- Catalogo de Generos
CREATE TABLE cat_generos (
    codigo_genero CHAR(1), 
    descripcion VARCHAR(50)
);

-- Catálogo de Estaciones
CREATE TABLE estaciones (
    id_estacion VARCHAR(100),
    nombre_estacion VARCHAR(150),
    zona VARCHAR(100)
);

-- Catálogo de Bicicletas
CREATE TABLE bicicletas (
    bici VARCHAR(20),    
    tipo_bicicleta VARCHAR(50),
    estatus VARCHAR(20)
);

-- Dimensión de Usuarios 
CREATE TABLE dim_usuarios (
    id_perfil INT,
    genero CHAR(1),
    edad INT
);

-- Dimensión de Fechas
CREATE TABLE dim_fechas (
    fecha DATE,
    anio INT,
    mes INT,
    dia INT
);

-- Dimensión de Tiempos
CREATE TABLE dim_tiempos (
    hora TIME,
    franja_horaria VARCHAR(20)
);


-- TABLA HISTÓRICO (PARTICIONADA)
CREATE TABLE historico_viajes (
    genero_usuario CHAR(1),
    edad_usuario INT,
    bici VARCHAR(20),
    ciclo_estacion_retiro VARCHAR(100), 
    fecha_retiro DATE,
    hora_retiro TIME,
    ciclo_estacion_arribo VARCHAR(100), 
    fecha_arribo DATE,
    hora_arribo TIME
)
PARTITION BY RANGE COLUMNS(fecha_retiro) (
    PARTITION p_2024 VALUES LESS THAN ('2025-01-01'), 
    PARTITION p_2025 VALUES LESS THAN ('2026-01-01'), 
    PARTITION p_2026 VALUES LESS THAN ('2027-01-01'), 
    PARTITION p_futuro VALUES LESS THAN (MAXVALUE)       
);

--  TABLA PRINCIPAL DE VIAJES (SIN PARTICIONES)
CREATE TABLE viajes (
    genero_usuario CHAR(1),
    edad_usuario INT,
    bici VARCHAR(20),
    ciclo_estacion_retiro VARCHAR(100), 
    fecha_retiro DATE,
    hora_retiro TIME,
    ciclo_estacion_arribo VARCHAR(100), 
    fecha_arribo DATE,
    hora_arribo TIME
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------
/*
Ruta donde se moveran los archivos a cargar
SHOW VARIABLES LIKE 'secure_file_priv';
Vaciar la tabla por completo de manera instantánea sin PK, FPK
TRUNCATE TABLE viajes;
*/
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- 2024
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Enero 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2024-01.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
	@edad_usuario,
	bici,
	ciclo_estacion_retiro,
	@fecha_retiro,
	hora_retiro,
	ciclo_estacion_arribo,
	@fecha_arribo,
	hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario ),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Febreo 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2024-02.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Marzo 2024

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2024-03.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL , @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro,'%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo,'%d/%m/%Y');
	
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Abril 2024

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2024-04.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL , CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro,'%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo,'%d/%m/%Y');
    
    
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- 2025
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Enero 2025
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2025-01.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
	@edad_usuario,
	bici,
	ciclo_estacion_retiro,
	@fecha_retiro,
	hora_retiro,
	ciclo_estacion_arribo,
	@fecha_arribo,
	hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario ),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Febreo 2025
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2025-02.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Marzo 2025

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2025-03.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL , @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro,'%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo,'%d/%m/%Y');
	

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Abril 2025

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2025-04.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL , CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro,'%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo,'%d/%m/%Y');
    

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- 2026
-- ------------------------------------------------------------------------------------------------------------------------------------------------


-- Carga Mayo2026
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2026-05.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(@edad_usuario AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Junio 2026
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2026-06.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(CAST(@edad_usuario AS Decimal(5,1)) AS UNSIGNED)),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Julio 2026
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2026-07.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL, CAST(CAST(@edad_usuario AS DECIMAL(5,1)) AS UNSIGNED )),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Carga Agosto 2026
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2026-08.csv'
INTO TABLE historico_viajes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
	@genero_usuario,
    @edad_usuario,
    bici,
    ciclo_estacion_retiro,
    @fecha_retiro,
    hora_retiro,
    ciclo_estacion_arribo,
    @fecha_arribo,
    hora_arribo
)
SET
	genero_usuario = IF(@genero_usuario = 'NULL' OR @genero_usuario = '?', NULL, @genero_usuario),
    edad_usuario = IF(@edad_usuario = 'NULL' OR @edad_usuario = '', NULL , CAST(CAST(@edad_usuario AS DECIMAL(5,1)) AS UNSIGNED )),
    fecha_retiro = STR_TO_DATE(@fecha_retiro, '%d/%m/%Y'),
    fecha_arribo = STR_TO_DATE(@fecha_arribo, '%d/%m/%Y');
    
-- Verificar cantidad de registros cargada
SELECT COUNT(*) AS Total_Viajes_ECOBICI FROM historico_viajes;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- EXTRACCIÓN Y POBLADO DE CATALOGOS 
-- ------------------------------------------------------------------------------------------------------------------------------------------------
/*  
Lost connection to MySQL server
Edit > Preferences. -> selecciona SQL Editor. -> sección MySQL Session. -> la opción DBMS connection read timeout interval (in seconds).
TRUNCATE TABLE cat_generos;
*/


-- Poblar la tabla 'viajes' 2025(1,2) y 2026(7,8)
INSERT INTO viajes
SELECT * FROM historico_viajes
WHERE 
    (YEAR(fecha_retiro) = 2025 AND MONTH(fecha_retiro) IN (1, 2))
    OR 
    (YEAR(fecha_retiro) = 2026 AND MONTH(fecha_retiro) IN (7, 8));

SELECT COUNT(*) AS Total_2025_2026 FROM viajes;


-- Poblar Catalogo de Generos.
INSERT INTO cat_generos (codigo_genero, descripcion)
SELECT DISTINCT 
    TRIM(genero_usuario),
    CASE TRIM(genero_usuario)
        WHEN 'M' THEN 'Masculino'
        WHEN 'F' THEN 'Femenino'
        WHEN 'O' THEN 'Otro/Omitido'
        ELSE 'No especificado'
    END
FROM viajes
WHERE TRIM(genero_usuario) IS NOT NULL AND TRIM(genero_usuario) != ''; 

-- Poblar Catalogo de Bicicletas
INSERT INTO bicicletas (bici, tipo_bicicleta, estatus)
SELECT DISTINCT
    TRIM(bici),
    'Mecánica',
    'Activa'
FROM viajes
WHERE TRIM(bici) IS NOT NULL AND TRIM(bici) != '';

-- Poblar Catalogo de Estaciones

INSERT INTO estaciones(id_estacion, nombre_estacion, zona)
SELECT DISTINCT
    id_est,
    CONCAT('Estación Ecobici ', id_est), 
    'CDMX'
FROM(
    SELECT ciclo_estacion_retiro AS id_est FROM viajes
    UNION
    SELECT ciclo_estacion_arribo AS id_est FROM viajes
) AS estaciones_unicas
WHERE id_est IS NOT NULL;

-- Poblar Usuarios Perfiles
INSERT INTO dim_usuarios(id_perfil, genero, edad)
SELECT
	ROW_NUMBER() OVER(ORDER BY genero_usuario, edad_usuario) AS id_perfil,
    genero_usuario,
    edad_usuario
FROM(
	SELECT DISTINCT genero_usuario, edad_usuario
    FROM viajes
    WHERE genero_usuario IS NOT NULL AND edad_usuario IS NOT NULL
) AS perfiles_unicos;

-- Poblar Fechas
INSERT INTO dim_fechas (fecha, anio, mes, dia)
SELECT DISTINCT 
    fecha, 
    YEAR(fecha), 
    MONTH(fecha), 
    DAY(fecha)
FROM (
    SELECT fecha_retiro AS fecha FROM viajes
    UNION
    SELECT fecha_arribo AS fecha FROM viajes
) AS fechas_unicas
WHERE fecha IS NOT NULL;

-- Poblar Tiempos
INSERT INTO dim_tiempos (hora, franja_horaria)
SELECT DISTINCT 
    hora,
    CASE 
        WHEN HOUR(hora) BETWEEN 6 AND 11 THEN 'Mañana'
        WHEN HOUR(hora) BETWEEN 12 AND 18 THEN 'Tarde'
        WHEN HOUR(hora) BETWEEN 19 AND 23 THEN 'Noche'
        ELSE 'Madrugada'
    END
FROM (
    SELECT hora_retiro AS hora FROM viajes
    UNION
    SELECT hora_arribo AS hora FROM viajes
) AS horas_unicas WHERE hora IS NOT NULL;

-- Revisar los datos poblados a las tablas
SELECT * FROM cat_generos;

SELECT COUNT(*) AS total_estaciones_unicas FROM estaciones;
SELECT * FROM estaciones LIMIT 50;

SELECT COUNT(*) AS total_bicicletas_unicas FROM bicicletas;
SELECT * FROM bicicletas LIMIT 500;

SELECT COUNT(*) AS total_perfiles FROM dim_usuarios;
SELECT * FROM dim_usuarios ORDER BY edad ASC LIMIT 50;

SELECT COUNT(*) AS dias_operacion_registrados FROM dim_fechas;
SELECT * FROM dim_fechas ORDER BY fecha ASC LIMIT 50;

SELECT COUNT(*) AS horas_unicas_registradas FROM dim_tiempos;
SELECT * FROM dim_tiempos ORDER BY hora ASC LIMIT 50000;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
--  ALTER TABLE para crear las Llaves Primarias y Foraneas.
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- LLAVES PRIMARIAS (PK)

ALTER TABLE cat_generos ADD PRIMARY KEY (codigo_genero);
ALTER TABLE estaciones ADD PRIMARY KEY (id_estacion);
ALTER TABLE bicicletas ADD PRIMARY KEY (bici);
ALTER TABLE dim_usuarios ADD PRIMARY KEY (id_perfil);
ALTER TABLE dim_fechas ADD PRIMARY KEY (fecha);
ALTER TABLE dim_tiempos ADD PRIMARY KEY (hora);


/*
Dependiendo del hardware de tu computadora (si tienes disco de estado sólido SSD o un disco duro mecánico HDD tradicional, y cuánta RAM tienes asignada al Buffer Pool).
18:10:25	ALTER TABLE viajes    
ADD CONSTRAINT fk_viajes_genero FOREIGN KEY (genero_usuario) 
REFERENCES cat_generos(codigo_genero),
ADD CONSTRAINT fk_viajes_bici FOREIGN KEY (bici) REFERENCES bicicletas(bici),
ADD CONSTRAINT fk_viajes_estacion_retiro FOREIGN KEY (ciclo_estacion_retiro) REFERENCES estaciones(id_estacion),
ADD CONSTRAINT fk_viajes_estacion_arribo FOREIGN KEY (ciclo_estacion_arribo) REFERENCES estaciones(id_estacion),
ADD CONSTRAINT fk_viajes_fecha_retiro FOREIGN KEY (fecha_retiro) REFERENCES dim_fechas(fecha),     
ADD CONSTRAINT fk_viajes_hora_retiro FOREIGN KEY (hora_retiro) REFERENCES dim_tiempos(hora)	6521891 row(s) affected Records: 6521891  Duplicates: 0  Warnings: 0	
851.937 sec

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 15 Minutos <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

*/

-- LLAVES FORÁNEAS (FK)
ALTER TABLE viajes
    ADD CONSTRAINT fk_viajes_genero FOREIGN KEY (genero_usuario) REFERENCES cat_generos(codigo_genero),
    ADD CONSTRAINT fk_viajes_bici FOREIGN KEY (bici) REFERENCES bicicletas(bici),
    ADD CONSTRAINT fk_viajes_estacion_retiro FOREIGN KEY (ciclo_estacion_retiro) REFERENCES estaciones(id_estacion),
    ADD CONSTRAINT fk_viajes_estacion_arribo FOREIGN KEY (ciclo_estacion_arribo) REFERENCES estaciones(id_estacion),
    ADD CONSTRAINT fk_viajes_fecha_retiro FOREIGN KEY (fecha_retiro) REFERENCES dim_fechas(fecha),
    ADD CONSTRAINT fk_viajes_hora_retiro FOREIGN KEY (hora_retiro) REFERENCES dim_tiempos(hora);
    
    -- ------------------------------------------------------------------------------------------------------------------------------------------------
--  SENTENCIAS DML: INSERT, UPDATE, DELETE, SELECT
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- INSERT
INSERT INTO estaciones (id_estacion, nombre_estacion, zona)
VALUE ('1111-FESA', 'Estacion FES Acatlan', 'Naucalpan');

SELECT * FROM estaciones WHERE id_estacion = '1111-FESA';

-- UPDATE
UPDATE bicicletas SET
	estatus = 'Mantenimiento'
	WHERE bici = '5200118';

SELECT * FROM bicicletas WHERE bici = '5200118';

-- DELETE
DELETE FROM estaciones
WHERE id_estacion = '1111-FESA';

SELECT * FROM estaciones WHERE id_estacion = '1111-FESA';

-- SELECT CON JOIN

SELECT 
    e.nombre_estacion AS Estacion_Origen,
    g.descripcion AS Genero,
    t.franja_horaria AS Horario,
    COUNT(v.bici) AS Total_Viajes
FROM viajes v

JOIN estaciones e ON v.ciclo_estacion_retiro = e.id_estacion
JOIN cat_generos g ON v.genero_usuario = g.codigo_genero
JOIN dim_tiempos t ON v.hora_retiro = t.hora

WHERE g.descripcion = 'Femenino' 
  AND t.franja_horaria = 'Mañana'

GROUP BY e.nombre_estacion, g.descripcion, t.franja_horaria
ORDER BY Total_Viajes DESC
LIMIT 5;