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
CREATE FUNCTION cadena(cadena VARCHAR(255)) RETURNS cadena VARCHAR(255) 
COMMENT "Mi primer procedimiento almacenado"
BEGIN
RETURN CONCAT(cadena, ' - ', length(cadena));
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
SHOW PROCEDURE STATUS;

-- 9. Muestra el código de creación del procedimiento prueba.
SHOW CREATE PROCEDURE prueba;


-- 11. Modifica el procedimiento prueba para que tenga el comentario "Procedimiento de prueba" y que se ejecute con los permisos del usuario que lo crea.
ALTER PROCEDURE prueba  SQL SECURITY DEFINER COMMENT 'Procedimiento de prueba';


-- 14. Crear un procedimiento que liste un número (pasado como parámetro ) de filas de la tabla emple. El procedimiento se ha de ejecutar con los permisos del usuario que lo invoca.
DELIMITER $
CREATE PROCEDURE listar(IN numFilas int)
BEGIN
SELECT * FROM empleados ORDER BY apellidos LIMIT numFilas;
END $
DELIMITER ;

--15. Crea un procedimiento que devuelva, como parámetro, el máximo salario de la tabla emple.
DELIMITER $
CREATE or REPLACE PROCEDURE SalarioMaximo(OUT maxSalario int)  
BEGIN
SELECT MAX(SALARIO) INTO maxSalario FROM empleados;
END$
DELIMITER ;

-- 16. Muestra un procedimiento que devuelva, como parámetro, el número de departamentos distintos hay en la tabla emple. El procedimiento se ha de ejecutar con los permisos del usuario que lo crea
DELIMITER $
CREATE OR REPLACE PROCEDURE muestraDepart(OUT numDepart int) SQL SECURITY DEFINER
BEGIN
SELECT COUNT(DISTINCT IDDEPART) INTO numDepart FROM empleados;
END $
DELIMITER ;
--MOSTRAR--
Set @numero = 0;
call muestraDepart(@numero);
SELECT @numero;

-- 17. Crea un procedimiento para insertar un nuevo alumno en la tabla alumnos. El procedimiento se ha de ejecutar con los permisos del usuario que lo invoca.
DELIMITER $
CREATE OR REPLACE PROCEDURE insertAlumno(IN NOM VARCHAR(255),IN APE VARCHAR(255), IN ALT INT, IN AUL INT) SQL SECURITY INVOKER
BEGIN
INSERT INTO alumnos (nombre, apellidos, altura, aula) Values 
(NOM, APE, ALT, AUL);
END $
DELIMITER ;
--Prueba
call insertAlumno(PARAMETROS Y QUE LOS PONGA OTRO);
SELECT insertAlumno;

-- 18. Crea una función que pasándole un oficio nos devuelva el número de empleados con ese oficio. Se ha de crear el procedimiento para el usuario root conectado desde la maquina local.
DELIMITER $
CREATE OR REPLACE DEFINER = root@localhost FUNCTION empleadosOficio(out oficioAElegir VARCHAR(255)) RETURNS INT
BEGIN
SELECT COUNT(*) AS 'recuento' FROM empleados WHERE oficio = oficioAElegir;
RETURN recuento;
END $
DELIMITER ;


-- 19. Crea un procedimiento, que pasándole un oficio, nos devuelva el número de empleados con ese oficio.
DELIMITER $
CREATE OR REPLACE PROCEDURE CONTADOROFICIOS (IN TRABAJOS VARCHAR(255))
BEGIN
SELECT COUNT(*) AS 'CANTIDAD EMPLEADOS' FROM empleados WHERE OFICIO = TRABAJOS;
END $
DELIMITER ;

CALL CONTADOROFICIOS('Empleado');
-- 20. Vamos a crear una función determinista que califica el salario de los empleados  con una cadena de texto: si el salario es superior o igual 5000 Alto, si es mayor o igual que 3000 pero menor 5000 Medio y bajo en los demás casos. Luego de la definición del procedimiento muestra los datos de los empleados con su salario calificado.
--IF--
DELIMITER $
CREATE FUNCTION califica(salario int) RETURNS VARCAHR(255)
DETERMINISTIC
BEGIN
IF SALARIO >= 5000 THEN RETURN "ALTO";
ELSEIF SALARIO <5000 AND SALARIO >= 3000 THEN RETURN "MEDIO";
ELSE RETURN "BAJO";
END IF;
END $
DELIMITER ;
--WHEN--
DELIMITER $
CREATE FUNCTION califica(salario int) RETURNS VARCAHR(255)
DETERMINISTIC
BEGIN
CASE
WHEN SALARIO >= 5000 THEN RETURN "ALTO";
WHEN SALARIO <5000 AND SALARIO >= 3000 THEN RETURN "MEDIO";
ELSE RETURN "BAJO";
END CASE;
END $
DELIMITER ;

-- 21. Crea un procedimiento que busque en la tabla empleados todos los empleados en que sus apellidos cumpla con un patrón.
DELIMITER $
CREATE OR REPLACE PROCEDURE BUSCAREMPLEADOS (IN PATRON VARCHAR(255))
BEGIN
SELECT * FROM empleados WHERE apellido = PATRON;
END $
DELIMITER ;

CALL BUSCAREMPLEADOS('%z');


-- 22. Crea un procedimiento que indicado un empleado le aumente la comisión en un cifra determinada.
DELIMITER $
CREATE OR REPLACE PROCEDURE AUMENTOCOMISION (IN CODIGO INT, IN AUMENTO INT)
BEGIN
UPDATE empleados SET COMISION = ifnull(COMISION,0) + AUMENTO WHERE CODIGO = CODEMP; 
END $
DELIMITER ;

CALL AUMENTOCOMISION(2, 5000000);

-- 23. Crea un función que dado un empleado calcule el número de años que lleva en la empresa.
DELIMITER $ 
CREATE OR REPLACE FUNCTION numeroAños(CODIGO INT) RETURNS INT
BEGIN
DECLARE A int;
SELECT TIMESTAMPDIFF(YEAR, FECHA_ALT, CURRENT_DATE) INTO A FROM empleados WHERE CODIGO = CODEMP; 
END $
RETURN A;
END $
DELIMITER ;
--prueba
SELECT numeroAños('Sanchez');

-- 24. Crea un procedimiento que busque en la tabla empleados todos los empleados en que sus apellidos cumpla con un patrón. Además deberá mostrar el número de empleados que cumple el patrón. Ha de tener el comentario de "busca procedimiento".
DELIMITER $
CREATE OR REPLACE PROCEDURE APELLIDOSYNUM (IN PATRON VARCHAR(255)) COMMENT 'busca procedimiento'
BEGIN
SELECT COUNT(*) AS 'numEmpleados' FROM empleados WHERE apellido = PATRON;
SELECT * FROM empleados WHERE apellido = PATRON;
END $ 
DELIMITER ;

-- 25. Crea un procedimiento que busque en la tabla empleados todos los empleados en que su apellidos cumpla con dos patrones. Si uno de ellos es nulo no se ha de tener en cuenta.
DELIMITER $
CREATE OR REPLACE PROCEDURE APELLIDOSYNUM (IN PATRON VARCHAR(255), IN PATRON1 VARCHAR(255))
BEGIN
SELECT COUNT(*) AS 'numEmpleados' FROM empleados WHERE apellido = ifnull(PATRON,'') AND apellido = ifnull(PATRON1,'');
SELECT * FROM empleados WHERE apellido = ifnull(PATRON,'') AND apellido = ifnull(PATRON1,'');
END $ 
DELIMITER ;


-- 26. Crea un procedimiento que indicándole un código de empleado nos devuelva el tipo de salario: El cual puede ser bajo si cobra menos de 2000, medio si cobra 2000 o más pero menos de 4000 y alto el resto. El procedimiento se ha de ejecutar con los permisos del usuario que lo invoca y se debe crear para el  usuario user desde la maquina local.


-- 27. Crea una función con dos parámetros: El primero será un número entero que representara un salario, el segundo será 0, 1 o -1. Si el segundo parámetro es 0 nos devolverá el número de empleado con un salario igual al primer parámetro.
-- Si vale 1 el número de empleados con un salario mayor y si vale -1 el número de empleados con un salario menor.
