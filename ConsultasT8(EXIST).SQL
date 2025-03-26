-- EXISTS
40.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART GROUP BY e2.IDDEPART HAVING e1.SALARIO < AVG(e2.SALARIO));

41.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART AND e1.JEFE IS NOT NULL);

42.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART AND e1.JEFE IS NULL AND SALARIO > 3000);

43.-    SELECT * FROM notas AS n1 WHERE EXISTS (SELECT * FROM notas AS n2 WHERE n1.NOTA = n2.NOTA) ORDER BY NOTA DESC LIMIT 1;

44.-    SELECT * FROM asignaturas AS a1 WHERE EXISTS (SELECT * FROM notas AS n2 WHERE a1.COD = n2.ASIGNATURA GROUP BY n2.ASIGNATURA HAVING COUNT(*)=0) AND NOMBRE LIKE '%os%';


46.-    SELECT 


48.-    SELECT


50.-    SELECT * FROM empleados, depart;

51.-    SELECT * FROM alumnos, asignaturas, notas;

52.-    SELECT empleados.apellido, depart.NOMBRE FROM empleados, depar empleados.IDDEPART = depart.IDDEPART;

53.-    SELECT empleados.apellido, depart.NOMBRE FROM empleados, depart WHERE empleados.IDDEPART = depart.IDDEPART and depart.NOMBRE NOT LIKE 'Ventas';

54.-    SELECT * FROM empleados, depart where empleados.IDDEPART = depart.IDDEPART and depart.LOC  LIKE 'Madrid';

55.-    SELECT asignaturas.nombre, alumnos.nombre, notas.nota FROM asignaturas, alumnos, notas WHERE asignaturas.COD = alumnos.codigo and notas.asignatura = asignaturas.COD;

56.-    SELECT asignaturas.nombre, alumnos.nombre, alumnos.apellidos FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno WHERE asignaturas.nombre like 'FOL';

57.-    SELECT notas.nota FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno WHERE alumnos.nombre like 'Ray' and asignaturas.nombre like 'FOL';

58.-    SELECT empleados.apellido, empleados.SALARIO, depart.nombre FROM empleados  JOIN depart USING(IDDEPART) WHERE empleados.OFICIO = (SELECT OFICIO FROM empleados where apellido = 'Gil' and comision IS null);

59.-    SELECT AVG(SALARIO) FROM empleados  JOIN depart USING(IDDEPART) WHERE depart.nombre like 'Contabilidad';

60.-    SELECT apellido FROM empleados JOIN depart USING(IDDEPART) WHERE empleados.SALARIO >ANY (SELECT SALARIO from empleados where IDDEPART IN(SELECT IDDEPART from depart WHERE NOMBRE like 'Ventas'));

61.-    SELECT DISTINCT NOMBRE, COUNT(*) AS 'EMPLEADOS' FROM depart JOIN empleados USING(IDDEPART) GROUP BY depart.NOMBRE;

62.-    SELECT MAX(SALARIO) AS 'MAXIMO', MIN(SALARIO) AS 'MIN', AVG(SALARIO) AS 'PROMEDIO' FROM empleados JOIN depart USING(IDDEPART) WHERE depart.NOMBRE LIKE 'Ventas';

63.-    SELECT IDDEPART, depart.nombre, MAX(SALARIO) AS 'MAXIMO', MIN(SALARIO) AS 'MIN', AVG(SALARIO) AS 'PROMEDIO' FROM empleados JOIN depart USING(IDDEPART) GROUP BY IDDEPART;

64.-    SELECT IDDEPART, depart.NOMBRE, empleados.OFICIO, MAX(SALARIO) AS 'MAXIMO', MIN(SALARIO) AS 'MIN', AVG(SALARIO) AS 'PROMEDIO' FROM empleados JOIN depart USING(IDDEPART) GROUP BY IDDEPART, OFICIO;

64(B).-    SELECT IDDEPART, depart.NOMBRE, empleados.OFICIO, MAX(SALARIO) AS 'MAXIMO', MIN(SALARIO) AS 'MIN', AVG(SALARIO) AS 'PROMEDIO' FROM empleados JOIN depart USING(IDDEPART) GROUP BY IDDEPART, OFICIO HAVING MAXIMO < 2000;

65.-    SELECT * from empleados JOIN depart USING(IDDEPART) where depart.nombre like 'Ventas' order by empleados.Salario DESC limit 1;

66.-    SELECT depart.IDDEPART, empleados.IDDEPART, depart.nombre, count(*) AS 'Total' FROM depart JOIN empleados USING(IDDEPART) GROUP by depart.IDDEPART ORDER by Total desc limit 1;

67.-    Realizan una tabla de apellido de empleado y nombre de su departamento
    La forma de usar las distintas formas de usar el join dando un mismo resultado.

68.-    SELECT apellido, nombre from empleados join depart using (IDDEPART) ORDER BY depart.NOMBRE;

69.-    SELECT DISTINCT apellido, nombre from empleados NATURAL join depart;

70.-    SELECT apellido, nombre from empleados NATURAL LEFT join depart;

71.-    SELECT apellido, nombre from empleados NATURAL RIGHT join depart;

72.-    SELECT asignaturas.NOMBRE, alumnos.NOMBRE, NOTAS.NOTA FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno WHERE notas.ALUMNO >= 5;

73.-     