#!/bin/bash

###############################################################################
## Download and install WP-CLI
###############################################################################

echo 'Make sure curl is installed...'
sudo apt-get -qq install curl
cd 
echo "Downloading wp-cli..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
echo "Making wp-cli executable..."
chmod +x wp-cli.phar 
echo "Moving wp-cli to be able to run it as wp"
sudo mv wp-cli.phar /usr/local/bin/wp
echo "Checking it works..."
wp --info
echo "WP-CLI installation complete!"

###############################################################################
## Creating the database
###############################################################################
