#!/bin/bash

sudo apt-get install apache2
# Browse to the IP address of your VPS in a browser. You should the default Apache page.

# Remove the default HTML page of Apache
sudo rm /var/www/html/index.html

# Create a new one from the file "new.index.html"
sudo nano /var/www/html/index.html

