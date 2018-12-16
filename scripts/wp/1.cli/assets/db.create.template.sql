CREATE DATABASE thisdatabase;
GRANT ALL PRIVILEGES ON thisdatabase.* TO 'user'@'localhost' IDENTIFIED BY 'pwd';
SHOW GRANTS FOR 'user'@'localhost';
FLUSH PRIVILEGES;