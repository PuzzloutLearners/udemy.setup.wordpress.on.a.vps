#!/bin/bash

# Inputs :
# $1    =>  the domain name
if [[ $1 == "" ]]
	then
		printf "The domain to install is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
if [[ $3 == "" ]]
	then
		printf "Please the username of the root user (not the actual \"root\" user).\n"
		exit 1;
fi
domain=$1
vpsinstallerdir=$2
username=$3

cd 
templatedomain=template.com
cd /var/www
sudo mkdir -p $domain/public_html 
cd /etc/apache2/sites-available/
sudo cp $templatedomain.conf $domain.conf
# https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sudo sed -i -e 's:'$templatedomain':'$domain':g' $domain.conf
sudo a2ensite $domain.conf
sudo service apache2 reload
cd 
sudo cp $vpsinstallerdir/vps/5.setup.apache2/assets/new.index.html /var/www/$domain/public_html/index.html
sudo sed -i -e 's:Coming soon:'$domain' website is coming soon:g' /var/www/$domain/public_html/index.html

echo "Setup SSL over $domain..."
/opt/letsencrypt/letsencrypt-auto --apache --renew-by-default -d $domain
echo "Check the validity dates of SSL certificate of $domain"
sudo openssl x509 -noout -dates -in /etc/letsencrypt/live/$domain1/cert.pem

