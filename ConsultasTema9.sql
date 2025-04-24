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
