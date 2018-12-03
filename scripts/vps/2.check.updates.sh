#!/bin/bash

###############################################################################
## Server commons installs
## 
## Variable checks
##
###############################################################################
echo "Download the packages to update"
sudo apt-get update

echo "Install the packages"
sudo apt-get upgrade

echo "If you see some packages that are listed as \"The following packages have been kept back\", it is because they need a server reboot \n"
echo "The following command to install those packages: \n"
echo "sudo apt-get dist-upgrade \n"
echo "sudo reboot"
