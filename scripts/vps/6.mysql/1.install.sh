#!/bin/sh

cd
sudo apt-get install mysql-server php-mysql
sudo mysql_secure_installation

# Connect to mysql
mysql -u root -p

# Type the root password

# Rename the root user
# SQL commands :
#
# rename user `root`@`localhost` to `puzzlout`@`localhost`;
# flush privileges;
