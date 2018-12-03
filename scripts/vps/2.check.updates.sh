#!/bin/bash

# Download the packages to update
sudo apt-get update

# Install the packages
sudo apt-get upgrade

# If you see some packages that are listed as "The following packages have been kept back", it is because they need a server reboot
# The following command to install those packages: 
# sudo apt-get dist-upgrade
# sudo reboot



