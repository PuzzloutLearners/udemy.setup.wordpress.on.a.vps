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

cd /etc/apache2/mods-available/
sudo cp dir.conf dir.conf.bak
sudo cp /home/$username/$vpsinstallerdir/vps/7.setup.php/assets/dir.conf dir.conf

sudo service apache2 restart

cd