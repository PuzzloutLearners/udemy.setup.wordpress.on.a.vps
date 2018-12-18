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

cat /home/$username/$repodir/scripts/wp/4.inst
all.wp/assets/wp-config.file.modifications.txt >> wp-config.php
sudo chmod 440 wp-config.php

cd public_html

rm index.html
touch .htaccess
sudo chown $username:www-data .htaccess
echo "Allow the user and webserver to edit the .htaccess"
sudo chmod 660 .htaccess

echo "From the browser, do the following:"
echo "  - Edit the permalink settings to: Post name"
echo "  - Trash the sample page"
echo "  - Trash the sample post"

cd
