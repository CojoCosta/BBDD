--------------RUTINAS ALMACENADAS----------------
-- SOLO VERDES
-- 1. Crea una función que calcule el cuadrado de un número.
DELIMITER $
CREATE FUNCTION cuadrado(num int)
BEGIN
RETURN num*num;
END $
DELIMITER ;

-- 2. Crea una función que pasándole una cadena de texto nos devuelva la cadena concatenada con un guion y su longitud (por ejemplo, con la cadena 'hola' devolverá 'hola - 4'). Tendrá que tener el comentario: "Mi primer procedimiento almacenado".
DELIMITER $
CREATE FUNCTION cadena(cadena string) RETURNS string
BEGIN
RETURN cadena + ' - ' + length(cadena);
END $
DELIMITER ;

-- 4. Crea el procedimiento, sin parámetros, prueba que nos permita listar todos los empleados de la tabla emple.
DELIMITER $
CREATE PROCEDURE prueba()
BEGIN
SELECT * FROM empleados;
END $
DELIMITER ;

-- 5. Muestra todos los procedimientos creados.
SHOW PROCEDURE STATUS LIKE '%';

-- 9. Muestra el código de creación del procedimiento prueba.
SHOW CREATE PROCEDURE prueba;


-- 11. Modifica el procedimiento prueba para que tenga el comentario "Procedimiento de prueba" y que se ejecute con los permisos del usuario que lo crea.
ALTER PROCEDURE prueba  SQL SECURITY DEFINER COMMENT 'Procedimiento de prueba';


-- 14. Crear un procedimiento que liste un número (pasado como parámetro ) de filas de la tabla emple. El procedimiento se ha de ejecutar con los permisos del usuario que lo invoca.



-- 16. Muestra un procedimiento que devuelva, como parámetro, el número de departamentos distintos hay en la tabla emple. El procedimiento se ha de ejecutar con los permisos del usuario que lo crea

-- 20. Vamos a crear una función determinista que califica el salario de los empleados  con una cadena de texto: si el salario es superior o igual 5000 Alto, si es mayor o igual que 3000 pero menor 5000 Medio y bajo en los demás casos. Luego de la definición del procedimiento muestra los datos de los empleados con su salario calificado.

-- 24. Crea un procedimiento que busque en la tabla empleados todos los empleados en que sus apellidos cumpla con un patrón. Además deberá mostrar el número de empleados que cumple el patrón. Ha de tener el comentario de "busca procedimiento".

-- 26. Crea un procedimiento que indicándole un código de empleado nos devuelva el tipo de salario: El cual puede ser bajo si cobra menos de 2000, medio si cobra 2000 o más pero menos de 4000 y alto el resto. El procedimiento se ha de ejecutar con los permisos del usuario que lo invoca y se debe crear para el  usuario user desde la maquina local.

-- 29. Define una función que devuelva el valor de la suma de los números desde 1 hasta el valor indicado en el parámetro (este valor está incluido en la suma). Hay que usar el bucle loop.

-- 32. Define un procedimiento que devuelva el valor de la suma de los números impares desde 1 hasta el valor indicado en el parámetro (este valor está incluido en la suma). Hay que usar el bucle While.

-- 34. Crea un procedimiento que pasándole una operación y una fecha nos indique los  siguientes eventos de la tabla agenda:
-- · A: Todas las actividades del mismo año que la fecha.
-- · M: Todas las actividades del mismo mes y año que la fecha.
-- · S: Todas las actividades de la misma semana y año que la fecha.
-- · D: Actividades del mismo día y año que la fecha.
-- · P: Actividades del mes siguiente a la fecha.
