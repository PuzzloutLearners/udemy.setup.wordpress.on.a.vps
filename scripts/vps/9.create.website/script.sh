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
sudo sed -i '/ServerAdmin/i\
        ServerName '$domain'
' $domain.conf
sudo sed -i '/ServerAdmin/i\
        ServerAlias www.'$domain'
' $domain.conf
sudo a2ensite $domain.conf
sudo service apache2 reload
cd 
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/new.index.html /var/www/$domain/public_html/index.html
sudo sed -i -e 's:Coming soon:'$domain' website is coming soon:g' /var/www/$domain/public_html/index.html
