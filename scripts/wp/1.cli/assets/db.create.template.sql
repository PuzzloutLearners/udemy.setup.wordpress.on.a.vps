CREATE DATABASE dbname;
GRANT ALL PRIVILEGES ON dbname.* TO 'dbusername'@'localhost' IDENTIFIED BY 'dbuserpwd';
SHOW GRANTS FOR 'dbusername'@'localhost';
FLUSH PRIVILEGES;