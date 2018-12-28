#!/bin/bash
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

sudo apt-get -qq install fail2ban
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo cp /home/$username/$vpsinstallerdir/vps/8.setup.fail2ban/assets/jail.local jail.local
cd jail.d/
sudo cp /home/$username/$vpsinstallerdir/vps/8.setup.fail2ban/assets/defaults-debian.conf defaults-debian.conf
sudo systemctl restart fail2ban

# Backup the defaults in case fail2ban is updated.
# TODO: how do you handle fail2ban updates???
sudo cp defaults-debian.conf defaults-debian.conf.custom

# If you use WP Scan, you will need to stop fail2ban service using the following commande
# sudo service fail2ban stop
#
# Don't forget to restart it when you are done
# sudo service fail2ban start
