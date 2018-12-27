#!/bin/bash

# $1 => UNIX user to create
###############################################################################
## Server commons installs
## 
## Variable checks
##
###############################################################################
if [[ $1 == "" ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
username=$1
###############################################################################
##
## First login
##
###############################################################################
echo "Add a new user"
adduser $username

echo "Add $username to the admin group"
usermod -a -G adm $username

echo "Check nano is installed to the latest version"
apt-get -qq install nano

# Under "User privilege specification", add the following line
# puzzlout  ALL=(ALL:ALL) ALL
#
# CTRL + X then Y then Enter
echo "Give $username root privileges"
sed -i '/root/i\
'$username'    ALL=(ALL:ALL) ALL
' /etc/sudoers

echo "Navigate the /etc/ssh dir"
cd /etc/ssh

# Under "Authentication", update PermitRootLogin to no
echo "Edit the ssh conf to set PermitRootLogin to no"
sudo sed -i -e 's:PermitRootLogin yes:PermitRootLogin no:g' sshd_config

echo "Restart ssh service"
service ssh restart

echo "Disconnect from Root. Try to connect with $username"
logout

# Try to connect from puzzlout
