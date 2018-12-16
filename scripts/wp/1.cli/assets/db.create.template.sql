CREATE DATABASE thisdatabase;
GRANT ALL PRIVILEGES ON thisdatabase.* TO 'user'@'localhost' IDENTIFIED BY 'password';
SHOW GRANTS FOR 'user'@'localhost';
FLUSH PRIVILEGES;