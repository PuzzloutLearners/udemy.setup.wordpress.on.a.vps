CREATE DATABASE db_name;
GRANT ALL PRIVILEGES ON db_name.* TO 'db_user_name'@'localhost' IDENTIFIED BY 'db_user_pwd';
SHOW GRANTS FOR 'db_user_name'@'localhost';
FLUSH PRIVILEGES;