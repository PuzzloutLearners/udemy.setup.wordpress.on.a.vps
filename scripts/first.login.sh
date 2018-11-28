#!/bin/bash

# Add a new user
adduser puzzlout

# Check nano is installed to the latest version
apt-get install nano

# Give the new user root privileges
visudo

# Under "User privilege specification", add the following line
# puzzlout  ALL=(ALL:ALL) ALL
#
# CTRL + X then Y then Enter

# Navigate the root dir
cd /etc/ssh
nano sshd_config
# Under "Authentication", update Authentication to no

# Restart ssh service
service ssh restart

# Disconnect from Root
# Try to connect from puzzlout
