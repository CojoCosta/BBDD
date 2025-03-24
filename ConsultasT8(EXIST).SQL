-- EXISTS
40.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART GROUP BY e2.IDDEPART HAVING e1.SALARIO < AVG(e2.SALARIO));

41.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART AND e1.JEFE IS NOT NULL);

42.-    SELECT * FROM empleados AS e1 WHERE EXISTS (SELECT * FROM empleados AS e2 WHERE e1.IDDEPART = e2.IDDEPART AND e1.JEFE IS NULL AND SALARIO > 3000);

43.-    SELECT * FROM notas AS n1 WHERE EXISTS (SELECT * FROM notas AS n2 WHERE n1.NOTA = n2.NOTA) ORDER BY NOTA DESC LIMIT 1;

44.-    SELECT * FROM asignaturas AS a1 WHERE EXISTS (SELECT * FROM notas AS n2 WHERE a1.COD = n2.ASIGNATURA GROUP BY n2.ASIGNATURA HAVING COUNT(*)=0) AND NOMBRE LIKE '%os%';

45.-    SELECT * FROM asignaturas AS a1 WHERE NOT EXISTS (SELECT * FROM notas AS n2 WHERE a1.COD = n2.ASIGNATURA GROUP BY n2.ASIGNATURA HAVING COUNT(ASIGNATURA)=0) ORDER BY COD DESC; (REVISAR)

46.-    SELECT 




50.-    SELECT * FROM empleados, depart;

51.-    SELECT * FROM alumnos, asignaturas, notas;

52.-    SELECT empleados.apellido, depart.NOMBRE FROM empleados, depar empleados.IDDEPART = depart.IDDEPART;

53.-    SELECT empleados.apellido, depart.NOMBRE FROM empleados, depart WHERE empleados.IDDEPART = depart.IDDEPART and depart.NOMBRE NOT LIKE 'Ventas';

54.-    SELECT * FROM empleados, depart where empleados.IDDEPART = depart.IDDEPART and depart.LOC  LIKE 'Madrid';

55.-    SELECT asignaturas.nombre, alumnos.nombre, notas.nota FROM asignaturas, alumnos, notas WHERE asignaturas.COD = alumnos.codigo and notas.asignatura = asignaturas.COD;

56.-    SELECT asignaturas.nombre, alumnos.nombre, alumnos.apellidos FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno WHERE asignaturas.nombre like 'FOL';

57.-    SELECT notas.nota FROM asignaturas JOIN alumnos JOIN notas on asignaturas.COD = notas.asignatura and alumnos.codigo = notas.alumno WHERE alumnos.nombre like 'Ray' and asignaturas.nombre like 'FOL';

58.-    SELECT empleados.apellido, empleados.SALARIO, depart.nombre FROM 