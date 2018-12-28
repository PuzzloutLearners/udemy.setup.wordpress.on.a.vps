#!/bin/sh
if [[ $1 == "" ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
username=$1
vpsinstaller=$2
# Create a new one from the file "new.index.html"
sudo cp $vpsinstaller/vps/5.setup.apache2/assets/new.index.html /var/www/html/index.html
cd /etc/apache2/conf-available/
# Backup the security conf file 
sudo cp security.conf security.conf.bak

# Modify the value "ServerTokens" from "OS" to "Prod".
sudo sed -i -e 's:ServerTokens OS:ServerTokens Prod:g' security.conf
# Comment the line "ServerSignature on"
sudo sed -i -e 's:ServerSignature On:#ServerSignature On:g' security.conf
# Uncomment the line "ServerSignature off"
sudo sed -i -e 's:#ServerSignature Off:ServerSignature Off:g' security.conf


sudo service apache2 restart
cd ..
sudo cp apache2.conf apache2.conf.bak
# Add the content of the asset file "mpm_prefork_module.conf" at the end of the apache2.conf file
sudo cat /home/$username/$vpsinstaller/vps/5.setup.apache2/assets/mpm_prefork_module.conf >> apache2.conf
# At the block "<Directory /var/www/>", modify "AllowOverride" to "All" to enable using .htaccess files
sudo nano apache2.conf
# Disable the auto index module (listing all the files is a security problem)
sudo a2dismod autoindex -f
# Enable the rewrite module
sudo a2enmod rewrite

# Restart Apache
sudo service apache2 restart

echo "Give $username ownership to /var/www"
sudo chown -R $username /var/www/

echo "add www-data to $username group"
sudo usermod -a -G www-data $username

cd

