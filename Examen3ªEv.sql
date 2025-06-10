-- Ejercicio 3
-- 1.- 
SELECT ventas.idventa, objetos.nombre, objetos.descripcion, ventas.cant FROM ventas JOIN objetos ON ventas.objetos = objetos.cod;

-- 2.-
SELECT ventas.idventa, objetos.nombre, clientes.nombre, clientes.direccion, ventas.fecha FROM clientes JOIN objetos JOIN ventas ON ventas.idcliente = clientes.id AND ventas.objeto = objetos.cod; 

-- 3.-
SELECT * FROM objetos LEFT JOIN ventas ON objetos.cod = ventas.objeto WHERE ventas.objeto is null;

-- 4.-
SELECT DISTINCT(objetos.nombre) FROM objetos JOIN clientes JOIN ventas ON objetos.cod = ventas.objeto AND clientes.id = ventas.idcliente WHERE clientes.apellidos LIKE 'Lannister' OR clientes.apellidos LIKE 'Stark';

-- 5.-
SELECT clientes.nombre, clientes.apellidos, clientes.lema, objetos.nombre FROM clientes JOIN objetos JOIN ventas ON clientes.id = ventas.idcliente and objetos.cod = ventas.objeto WHERE objetos.nombre LIKE 'Huevos de dragón';

-- 6.-
SELECT * FROM objetos JOIN clientes JOIN ventas ON objetos.cod = ventas.objeto AND clientes.id = ventas.idcliente WHERE clientes.apellidos LIKE 'Lannister' AND objetos.stock > (SELECT objetos.stock FROM objetos WHERE objetos.nombre like 'Acero valyrio');

-- Ejercicio 4
-- Vista
CREATE VIEW vis (cliente, objeto, precio, cantidad) AS SELECT clientes.nombre, objetos.nombre, objetos.precio, ventas.cant FROM objetos JOIN ventas JOIN clientes ON objetos.cod = ventas.objeto AND clientes.id = ventas.idcliente WHERE objetos.stock > 10;

-- Ejercicio 5
-- a)
DELIMITER $
CREATE OR REPLACE PROCEDURE posicion (in apellido VARCHAR(255), IN inicio INT, in final INT, OUT salida INT) 
BEGIN
if (inicio > final) THEN SET salida =(-1);
ELSE SET  salida = final - inicio;
END if;
END $
DELIMITER ;

SET @dif = 0;
CALL posicion('Stark', 4, 6, @dif);
SELECT @dif;


-- b)
DELIMITER $
CREATE OR REPLACE PROCEDURE suma(IN ventaID INT)
BEGIN
SELECT ventas.cant FROM ventas WHERE ventas.idventa = ventaID;
UPDATE ventas SET ventas.cant = ventas.cant + 1 WHERE ventas.idventa = ventaID;
SELECT ventas.cant FROM ventas WHERE ventas.idventa = ventaID;
END $
DELIMITER ;


-- c)
DELIMITER $
CREATE OR REPLACE FUNCTION multiplica(ventaID INT) RETURNS FLOAT
BEGIN 
DECLARE cantidad INT;
DECLARE precio FLOAT;
DECLARE resultado FLOAT;
SELECT ventas.cant INTO cantidad FROM ventas WHERE ventas.idventa = ventaID;
SELECT objetos.precio INTO precio FROM ventas JOIN objetos ON ventas.objeto = objetos.cod WHERE ventas.idventa = ventaID;
SET resultado = cantidad * precio;
RETURN resultado;
END $
DELIMITER ;

SELECT multiplica(3);

-- OTRA FORMA
delimiter $
CREATE or replace FUNCTION parametro (venta_id INT)
RETURNS FLOAT
BEGIN
DECLARE total FLOAT;        
set total= (SELECT v.cant * o.precio FROM ventas v JOIN objetos o ON v.objeto = o.cod WHERE v.idventa=venta_id);

RETURN total;
END $
delimiter ;

SELECT parametro(1);