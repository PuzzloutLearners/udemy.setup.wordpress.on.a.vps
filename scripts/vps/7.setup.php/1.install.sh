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

cd

sudo apt-get install -qq php libapache2-mod-php php-mcrypt php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
php -v

cd /etc/php/7.0/apache2/
sudo cp php.ini php.ini.bak
sudo cp /home/$username/$vpsinstallerdir/scripts/vps/7.setup.php/assets/php.ini.optimized php.ini

cd
