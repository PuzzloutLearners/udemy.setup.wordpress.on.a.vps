CREATE DATABASE db_name;
GRANT ALL PRIVILEGES ON db_name.* TO 'db_user'@'localhost' IDENTIFIED BY 'db_user_pwd';
SHOW GRANTS FOR 'db_user'@'localhost';
FLUSH PRIVILEGES;