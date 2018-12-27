#!/bin/sh

cd
sudo apt-get -qq install mysql-server php-mysql
sudo mysql_secure_installation