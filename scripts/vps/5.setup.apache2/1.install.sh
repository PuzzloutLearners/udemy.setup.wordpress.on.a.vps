#!/bin/bash

sudo apt-get --qq install apache2
# Browse to the IP address of your VPS in a browser. You should the default Apache page.

# Remove the default HTML page of Apache
sudo rm /var/www/html/index.html