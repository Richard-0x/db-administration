
SHOW VARIABLES LIKE 'secure_file_priv';

USE lopezricardo_ventas;

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categoria.txt'
INTO TABLE categoria
FIELDS TERMINATED BY '|';

-- Carga Ricardo Lopez Ramirez
TRUNCATE TABLE PRODUCTOS;

ALTER TABLE PRODUCTOS MODIFY pkg_tipo VARCHAR(50);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/producto.txt'
INTO TABLE PRODUCTOS
FIELDS TERMINATED BY '|';

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/region.txt'
INTO TABLE REGION
FIELDS TERMINATED BY '|';

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tienda.txt'
INTO TABLE TIENDA
FIELDS TERMINATED BY '|';

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ventas.txt'
INTO TABLE VENTAS
FIELDS TERMINATED BY '|';

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/periodo.txt'
INTO TABLE PERIODO
FIELDS TERMINATED BY '|'
(per_id, @fecha, dia, semana, mes, trimestre, año)
SET fecha = STR_TO_DATE(@fecha, '%d/%m/%Y');

-- Carga Ricardo Lopez Ramirez
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/promocion.txt'
INTO TABLE PROMOCION
FIELDS TERMINATED BY '|'
(promo_id, promo_tipo, promo_desc, valor, @fecha_inicio, @fecha_fin)
SET fecha_inicio = STR_TO_DATE(@fecha_inicio, '%d/%m/%Y'),
	fecha_fin = STR_TO_DATE(@fecha_fin, '%d/%m/%Y');

SELECT 'CATEGORIA' AS Tabla, count(*) AS Total_Registros FROM CATEGORIA
UNION ALL
SELECT 'PERIODO', count(*) FROM PERIODO
UNION ALL
SELECT 'PRODUCTOS', count(*) FROM PRODUCTOS
UNION ALL
SELECT 'PROMOCION', count(*) FROM PROMOCION
UNION ALL
SELECT 'REGION', count(*) FROM REGION
UNION ALL
SELECT 'TIENDA', count(*) FROM TIENDA
UNION ALL
SELECT 'VENTAS', count(*) FROM VENTAS;

-- Verificación Final - Ricardo Lopez Ramirez
select count(*) from categoria;
select count(*) from periodo;
select count(*) from productos;
select count(*) from promocion;
select count(*) from region;
select count(*) from tienda;
select count(*) from ventas;

