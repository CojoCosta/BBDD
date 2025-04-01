2 / 4 / 7 / 8 / 9 / 10 / 11 / 15 / 18 / 19 / 20 / 22 / 23 / 25 / 27 / 28 / 30
-- 1. Lista los usuarios dados de alta en el servidor junto con el equipo desde donde se
-- pueden conectar

-- 2. Crea el usuario user1 con clave pass y que pueda conectarse desde la máquina local.
    CREATE USER user1@localhost IDENTIFY BY 'pass';

-- 4. Otorga con el usuario user1@localhost permisos de consulta al usuario user1@localhost sobre la tabla emple de la base de datos tema8. ¿Qué ha pasado y por qué?¿Como lo solucionarías?. Solucionalo.

-- 7. Cambia la contraseña al usuario user1@localhost a 'password' y reconéctate.
    SET PASSWORD FOR user1@localhost = PASSWORD('password');

-- 8. Otorga privilegios de consulta a la columna nombre y loc de la taba depart para el usuario user1 desde la maquina local.


-- 9. Consulta todos los datos disponibles en depart. ¿Qué ha pasado?. Consulta solo los datos a los que se está autorizado. ¿Qué sucede?
    

-- 10.Crea de forma simultánea un usuario, user2, con clave pass2 y que solo puede acceder desde la máquina local y un usuario user3 que puede acceder desde el equipo de un compañero de clase con clave pass3

-- 11. Permite que user2 tenga todos los privilegios sobre la base de datos tema8 y que user3 tenga los privilegios de consulta e inserción sobre la tabla depart.

-- 15.Conéctate a la base de datos de tu compañero e inserta una fila en su tabla depart y es su tabla emple. ¿Qué sucede?

-- 18.Renombra los usuarios user2 y user3 a usuario2 y usuario3 con sus correspondientes hosts. Muestra los usuarios de MySQL y comprueba que los cambios se han realizado de forma correcta.

-- 19. Elimina del usuario3 (antes user3) que se conecta desde el equipo de tu compañero la posibilidad de consultar la vista vista.

-- 20.Borra este usuario y consulta la tabla de ususarios

-- 22.Añade a usuario2 desde el equipo local la posibilidad de borrar y crear tablas en la base de datos tema8.

-- 23. Para el usuario2 desde el equipo local, permite que pueda actualizar el valor de la columna jefe de la tabla empleados e insertar en comisión.

-- 25.Actualiza el código de jefe a 2 para aquellos cuyo codigo de jefe sea uno. ¿Qué ha sucedido?

-- 27. Limita al user1 a tener como mucho dos conexiones simultáneas y comprueba que no se pueden establecer tres conexiones simultáneas.

-- 28. Limita al user1 a poder realizar como mucho 10 consultas a la hora y compruébalo.

-- 30.Actualiza los privilegios