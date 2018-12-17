#!/bin/sh

cd
sudo apt-get install -qq mysql-server php-mysql
sudo mysql_secure_installation