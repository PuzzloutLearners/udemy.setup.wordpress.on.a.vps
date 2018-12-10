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

###############################################################################
##
## First login
##
###############################################################################
echo "Add a new user"
adduser $1

echo "Add $1 to the admin group"
usermod -a -G adm puzzlout

echo "Check nano is installed to the latest version"
apt-get install nano

# Under "User privilege specification", add the following line
# puzzlout  ALL=(ALL:ALL) ALL
#
# CTRL + X then Y then Enter
echo "Give the new user root privileges"
visudo

echo "Navigate the /etc/ssh dir"
cd /etc/ssh

# Under "Authentication", update PermitRootLogin to no
echo "Edit the ssh conf"
nano sshd_config

echo "Restart ssh service"
service ssh restart

echo "Disconnect from Root"
exit

# Try to connect from puzzlout
