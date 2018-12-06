#!/bin/sh

cd
nano php.ini
# Copy the content of the asset file "php.ini.optimised" in /etc/php/7.0/apache2
sudo cp php.ini /etc/php/7.0/apache2/php.ini

sudo service apache2 restart
