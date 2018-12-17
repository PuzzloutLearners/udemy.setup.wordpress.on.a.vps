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
vpsinstallerdir=$2
# Create a new one from the file "new.index.html"
sudo cp $vpsinstaller/scripts/vps/5.setup.apache2/assets/new.index.html /var/www/html/index.html
cd /etc/apache2/conf-available/
# Backup the security conf file 
sudo cp security.conf security.conf.bak

sudo cp /home/$username/$vpsinstaller/scripts/vps/5.setup.apache2/assets/security.conf security.conf
# Modify the value "ServerTokens" from "OS" to "Prod".
# Uncomment the line "ServerSignature off"
# Comment the line "ServerSignature on"

sudo service apache2 restart
cd ..
sudo cp apache2.conf apache2.conf.bak
sudo cp /home/$username/$vpsinstaller/scripts/vps/5.setup.apache2/assets/apache2.conf apache2.conf
# Add the content of the asset file "mpm_prefork_module.conf" at the end of the apache2.conf file
# At the block "<Directory /var/www/>", modify "AllowOverride" to "All" to enable using .htaccess files

# Disable the auto index module (listing all the files is a security problem)
sudo a2dismod autoindex -f
# Enable the rewrite module
sudo a2enmod rewrite

# Restart Apache
sudo service apache2 restart
cd

