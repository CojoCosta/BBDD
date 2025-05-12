2. CREATE USER user1@localhost IDENTIFIED BY 'pass';


4. GRANT SELECT ON tema5.empleados TO user1@localhost;
-- Hay que darle permisos de consulta al usuario user1
-- desde el usuario root


7. SET PASSWORD FOR user1@localhost = PASSWORD('password');


8. GRANT SELECT(nombre, loc) ON TEMA5.depart TO user1@localhost;


9.  
-- Informa del error de no tener permisos en la columna iddepart.
-- Al consultar solo los permitidos si deja y salen por pantalla.


10.
CREATE USER user2@localhost IDENTIFIED BY 'pass2';
CREATE USER user3@"192*" IDENTIFIED BY 'pass3';


11.
GRANT ALL ON tema8.* TO user2@localhost WITH GRANT OPTION;
GRANT ALL ON tema5.depart TO user3@"192*";


15.
-- No permite hacerlo en la tabla empleados por los permisos


18.
RENAME USER user2@localhost TO usuario2@localhost IDENTIFIED BY 'pass2'
RENAME USER user3@'192*' TO usuario3@'192*' IDENTIFIED BY 'pass3'


19.
REVOKE SELECT ON *.* TO usuario3@'192*';


20.
DROP USER usuario3@'192*';


22.
GRANT CREATE, DELETE ON tema8.* TO usuario2@localhost;


23.
GRANT UPDATE(jefe), INSERT(comision) ON tema5.empleados
TO usuario2@localhost


25.
UPDATE empleados.JEFE SET JEFE=2 WHERE JEFE=1;
-- UPDATE comando negado para usuario: 'usuarioo2'@'localhost' para tabla `empleados`.`jefe`


27.
CREATE OR REPLACE // ALTER USER user1@localhost IDENTIFIED BY pass WITH MAX_USER_CONNECTIONS_PER_HOUR 2;


28.
CREATE OR REPLACE // ALTER USER user1@localhost IDENTIFIED BY pass WITH
MAX_QUERIES_PER_HOUR 10;

30.
FLUSH PRIVILEGES;

-----------------------VISTAS--------------------------
31, 32, 33, 34, 35, 36, 42, 43, 45, 47, 49, 53, 55

31.Crea una vista con nombre ed que muestre toda la información de la tabla empleados relacionada con la información de la tabla departamentos.
CREATE OR REPLACE view ed AS SELECT * FROM tema5.empleados JOIN tema5.depart USING (IDDEPART);

32. Muestra a partir de la vista creada en el ejercicio anterior las siguientes columnas: el apellido de los empleados, su oficio y el nombre del departamento al que pertenecen.
SELECT apellido, oficio, nombre FROM ed;

33. Modifica la vista ed con replace para que tenga las columnas: apellido, oficio y nombre del departamento cambiando sus nombres a los siguientes: nombre, oficio y departamento.
CREATE OR REPLACE view ed(nombre, oficio, departamento) AS SELECT APELLIDO, OFICIO, NOMBRE FROM tema5.empleados JOIN tema5.depart USING (IDDEPART);

34.A partir de la vista anterior define la vista ed2 que muestre el nombre del empleado y el nombre del departamento.
CREATE OR REPLACE view ed2(nombredelempleado, nombredeldepartamento) AS SELECT nombre, departamento FROM tema5.ed;

35. Elimina la vista ed.
DROP VIEW ed;

36.Consulta los datos de la vista ed2. ¿Que sucede?.
SELECT * FROM ed2;
Da este error "#1356 - View 'tema5.ed2' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them"

39. Crea la vista notas_asig_alu que relacione los alumnos con sus asignaturas y notas.
CREATE OR REPLACE VIEW notas_asig_aluAS SELECT alumno, asignatura, nota, fecha, alumnos.nombre, codigo,  apellidos, altura, aula, cod, asignaturas.nombre AS 'nome' FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno;

40. Consulta los datos de la vista notas_asig_alu.
SELECT * FROM notas_asig_alu;

42. Muestra la sentencia de creación de la vista notas_asig_alu.
SHOW CREATE VIEW notas_asig_alu;

43.Crea la vista notasAlu a partir de la vista notas_asig_alu que muestre los siguientes campos: el nombre como nombre, la asignatura como materia y la nota como calificación de aquellos alumnos que han aprobado.
CREATE OR REPLACE VIEW notasAlu (nombre, materia, calificaciones) AS SELECT nombre, asignatura, nota FROM notas_asig_alu WHERE nota >= 5;

45. Modifica la vista notasAlu con alter view y añádele el campo Apellido.
ALTER VIEW notasAlu AS SELECT nombre, asignatura, nota, apellidos FROM notas_asig_alu;


47.Crea la vista salarios que muestre el apellido y la localización de los empleados que tienen salario mayor que 1200 menos los que tienen comisión mayor que 100.
CREATE VIEW salarios(apellido, localización) AS SELECT apellido, loc FROM empleados JOIN depart USING(IDDEPART) WHERE salario > 1200 AND ifnull(comision,0) < 100;


49.Crea la vista empleados que muestra los departamentos de los empleados. ¿Qué sucede?
CREATE VIEW empleados (empleado, departamentos) AS SELECT apellido, nombre FROM empleados JOIN depart USING(iddepart);
-- no se puede crear una vista con el nombre de la tabla ya creada


53.Crea la vista led que relacione los usuarios con sus departamentos incluyendo los departamentos que no tengan usuarios asignados. Consulta los datos que contiene.
CREATE OR REPLACE VIEW led AS SELECT * FROM empleados RIGHT JOIN depart USING (IDDEPART);

-----------------------TRANSACCIONES--------------------------
58, 59, 60, 62, 63, 66, 67, 68, 69, 70, 71

58.Comienza una transacción e inserta el valor 20 en la tabla transación. Muestra los datos.
BEGIN;
INSERT INTO transacción VALUES (20);
SELECT * FROM transacción;

59. Deshaz la transacción y vuelve a mostrar los dados. ¿Qué ha sucedido?.
ROLLBACK;
SELECT * FROM transacción;

60.Comienza una transacción e inserta el valor 20. Muestra los datos. Cierra la conexión con la base de datos. Vuelve a conectarte y muestra los datos. ¿Qué ha sucedido?.
BEGIN;
INSERT INTO transacción VALUES (20);
SELECT * FROM transacción;

62. En la conexión 1 comienza una transacción e inserta el valor 20. Muestra los datos de la tabla transacción. En la conexión2 muestra los datos de la tabla transacción. ¿Qué ha sucedido?.
-- No se ve el dato introducido por no realizar el COMMIT.

63.Confirma los cambios en la conexión1. Muestra los datos tanto en la conexión1 como en la conexión2. ¿Qué ha sucedido?.
-- Se ven los cambios por haber realizado el COMMIT.

66.Comenzamos una transacción e insertamos el valor 100 en la tabla transacciones.
Realizamos los siguientes pasos visualizando cada uno de ellos:
· Creamos el punto de recuperación uno.
· Actualizamos el valor de 100 a 101.
· Creamos el punto de recuperación dos.
· Insertamos el valor 102.
· Creamos el punto de recuperación tres.
· Insertamos el valor 103.
· Volvemos al punto tres.
· Volvemos al punto dos.
· Realizamos un commit.
· Volvemos al punto 1 ¿Qué ha sucedido?. Da error porque con el COMMIT estamos fuera de la transaccion
BEGIN;
INSERT INTO transacción VALUES (100);
SELECT * FROM transacción;
SAVEPOINT punto1;
SELECT * FROM transacción;
UPDATE transacción SET valores = 101 WHERE valores = 100;
SELECT * FROM transacción;
SAVEPOINT punto2;
SELECT * FROM transacción;
INSERT INTO transacción VALUES (102)
SELECT * FROM transacción;
SAVEPOINT punto3;
SELECT * FROM transacción; negado
INSERT INTO transacción VALUES (103)
SELECT * FROM transacción;
ROLLBACK TO punto3;
SELECT * FROM transacción;
ROLLBACK TO punto2;
SELECT * FROM transacción;
COMMIT;
SELECT * FROM transacción;
ROLLBACK TO punto1;
SELECT * FROM transacción;


67.Comienza una transacción e inserta el valor 110. Creamos un punto de recuperación uno. Insertamos el valor 111 y creamos la base de datos tema9 y volvemos al punto de restauración uno. ¿Qué ha pasado?.--Da error porque con la creación de una base de datos es como con el  COMMIT, estamos fuera de la transaccion
BEGIN;
INSERT INTO transacción VALUES(110);
SAVEPOINT punto1;
INSERT INTO transacción VALUES(111);
CREATE DATABASE tema9;
ROLLBACK TO punto1;


68.Comienza una transacción e inserta el valor 120. Creamos un punto de recuperación  uno. Insertamos el valor 121 y volvemos a crear el punto de restauración uno. Volvemos al punto de restauración uno. ¿Qué ha pasado?. Inserta el valor 122. Realiza un commit y vuelve al punto de restauración uno. ¿Qué ha pasado?. --Da error porque con el COMMIT estamos fuera de la transaccion
BEGIN;
INSERT INTO transacción VALUES(120);
SAVEPOINT punto1;
INSERT INTO transacción VALUES(121);
SAVEPOINT punto1;
ROLLBACK TO punto1; -- Vuelve al que hemos creado de ultimo porque lo sobreescribe
INSERT INTO transacción VALUES(122);
COMMIT;
ROLLBACK TO punto1;


69.Bloquear la tabla transacción para lectura en la conexión1. Visualizar los datos en la conexion1 y la conexion2. Intenta insertar en ambas conexiones. ¿Qué sucede?. Libera el bloqueo.
LOCK TABLE transacción READ;
SELECT * FROM transacción;

INSERT INTO transacción VALUES (15) --INTENTO. EN LA QUE YO HAGO DA ERROR Y LA OTRA QUEDA CARGANDO HASTA EL DESBLOQUEO
UNLOCK TABLES;


70.Bloquear la tabla transacción para escritura. Visualiza los datos en la conexion1 y la conexion2. Intenta insertar un valor en la conexion1 y la conexion2. ¿Qué sucede?. Libera el bloqueo.
LOCK TABLES transacción WRITE;
SELECT * FROM transacción;

INSERT INTO transacción VALUES (15) --INTENTO. EN LA QUE BLOQUEO FUNCIONA Y LA OTRA NO
UNLOCK TABLES;


71.Vamos a crear tres conexiones contra el servidor MySQL. En la primera creamos un bloqueo de lectura sobre la tabla transacción, en la segunda un bloqueo de escritura y en la tercera un bloqueo de lectura. Consulta los datos en las tres conexiones. ¿Qué sucede?.
--1ª
LOCK TABLES transacción READ;  
SELECT * FROM transacción;
--PARA QUE EL RESTO FUNCIONE
UNLOCK TABLES;

--2ª SE QUEDA AL BLOQUEO DE QUE SE DESBLOQUEE EL PRIMER BLOQUEO
LOCK TABLES transacción WRITE; 
SELECT * FROM transacción;
--PARA QUE EL RESTO FUNCIONE
UNLOCK TABLES;

--3ª SE QUEDA AL BLOQUEO DE QUE SE DESBLOQUEE EL PRIMER Y SEGUNDO BLOQUEO
LOCK TABLES transacción READ;  
SELECT * FROM transacción;