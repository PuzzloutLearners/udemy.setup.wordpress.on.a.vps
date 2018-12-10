#!/bin/bash


cd
cd /var/www
domain=udemy.puzzlout.com
sudo mkdir -p $domain/public_html 
cd /etc/apache2/sites-available/
sudo cp 000-default.conf $domain.conf
# https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sudo sed -i -e 's:ServerAdmin webmaster@localhost:ServerAdmin puzzlout@gmail.com:g' $domain.conf
sudo sed -i -e 's:DocumentRoot /var/www/html:DocumentRoot /var/www/$domain/public_html:g' $domain.conf
sudo set -i 
