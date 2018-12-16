#!/bin/bash

# Create a template conf file.
cd
templatedomain=template.com
adminemail="puzzlout@gmail.com"
cd /etc/apache2/sites-available/
sudo cp 000-default.conf $templatedomain.conf
# https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sudo sed -i -e 's:ServerAdmin webmaster@localhost:ServerAdmin '$adminemail':g' $templatedomain.conf
sudo sed -i -e 's:DocumentRoot /var/www/html:DocumentRoot /var/www/'$templatedomain'/public_html:g' $templatedomain.conf
sudo sed -i '/ServerAdmin/i\
        ServerName '$templatedomain'
' $templatedomain.conf
sudo sed -i '/ServerAdmin/i\
        ServerAlias www.'$templatedomain'
' $templatedomain.conf

# Disable the apache default website
sudo a2dissite 000-default.conf
sudo service apache2 reload

# Remove the html folder as it is not useful anymore.
sudo rm -R /var/www/html