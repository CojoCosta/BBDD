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