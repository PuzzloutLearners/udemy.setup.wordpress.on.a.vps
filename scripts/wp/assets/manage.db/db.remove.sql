--SQL commands

REVOKE PERMISSION ON dbname.* FROM 'dbusername'@'localhost';
DROP USER 'dbusername'@'localhost';
DROP DATABASE dbname;
FLUSH PRIVILEGES;