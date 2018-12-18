#!/bin/bash

domain="asteol.puzzlout.com"
username="puzzlout"
cd /var/www/$domain/public_html

wp core download
wp core config --dbname=$dbname --dbuser=$dbuser --dbpass=$dbuserpwd --dbprefix=$wptableprefix
wp core install --url=http://asteol.puzzlout.com --title=$projecttitle --admin_user=$wpadmuser --admin_password=$wpadmuserpwd --admin_email=$projectemail

sudo chown -R $username:www-data /var/www/$domain
sudo find /var/www -type d -exec chmod 775 {} \;
sudo find /var/www -type f -exec chmod 664 {} \;

mv wp-config.php ../
rm wp-config-sample.php
cd ..
