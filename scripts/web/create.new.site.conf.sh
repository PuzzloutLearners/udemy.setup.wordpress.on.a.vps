#!/bin/bash

# Inputs :
# $1    =>  the domain name
if [[ $1 == "" ]]
	then
		printf "The domain to install is required.\n"
		exit 1;
fi

cd 
templatedomain=template.com
domain=$1
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
