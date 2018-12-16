CREATE DATABASE dbname;
GRANT ALL PRIVILEGES ON dbname.* TO 'dbuser'@'localhost' IDENTIFIED BY 'dbuserpwd';
SHOW GRANTS FOR 'dbuser'@'localhost';
FLUSH PRIVILEGES;