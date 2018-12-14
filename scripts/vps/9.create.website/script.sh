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
# No need to enable the template site
#sudo a2ensite $templatedomain.conf
#sudo service apache2 reload

# Create a specific site using the template conf file.
cd 
templatedomain=template.com
domain=udemy.puzzlout.com
cd /var/www
sudo mkdir -p $domain/public_html 
cd /etc/apache2/sites-available/
sudo cp $templatedomain.conf $domain.conf
# https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sudo sed -i -e 's:'$templatedomain':'$domain':g' $domain.conf
sudo a2ensite $domain.conf
sudo service apache2 reload
cd 
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/new.index.html /var/www/$domain/public_html/index.html
sudo sed -i -e 's:Coming soon:'$domain' website is coming soon:g' /var/www/$domain/public_html/index.html

# Disable the apache default website
sudo a2dissite 000-default.conf
sudo service apache2 reload

# Remove the html folder as it is not useful anymore.
sudo rm -R /var/www/html