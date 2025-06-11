-- TEMA 9
2.-
CREATE OR REPLACE USER user1@localhost IDENTIFIED BY 'pass';

4.-
GRANT SELECT ON tema5.empleados TO user1@localhost;

7.-
SET PASSWORD FOR user1@localhost = PASSWORD('password');

8.-
GRANT SELECT (nombre, loc) ON tema5.depart TO user1@localhost;

10.-
CREATE OR REPLACE USER user2@localhost IDENTIFIED BY 'pass', 'user3@192.168.*' IDENTIFIED BY 'pass3';

11.-
GRANT ALL ON tema5.* TO user2@localhost WITH GRANT OPTION;
GRANT SELECT, INSERT ON tema5.depart TO user3@'192.168.*';

18.-
RENAME USER user2@localhost to usuario2@localhost;
RENAME USER user3@'192.168.*' TO usuario3@'192.168.*';

19.-
REVOKE SELECT on salarios FROM user3@'192.168.*';

20.-
drop user user3@'192.168.*';

22.-
GRANT DROP, CREATE ON tema5.* TO usuario2@localhost;

23.-
GRANT UPDATE (jefe) ON tema5.empleados TO usuario2@localhost;

27.-
ALTER USER user1@localhost IDENTIFIED by 'password' MAX_USER_CONNECTIONS_PER_HOUR = 2;

29.-
DROP USER usuario2@localhost;

30.-
FLUSH PRIVILEGES;


