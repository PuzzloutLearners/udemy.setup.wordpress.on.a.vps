#!/bin/bash

repodir="vpsinstaller"
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

cat /home/$username/$repodir/scripts/wp/4.install.wp/assets/wp-config.file.modifications.txt >> wp-config.php
sudo chmod 440 wp-config.php

cd public_html

rm index.html
touch .htaccess
sudo chown $username:www-data .htaccess
echo "Allow the user and webserver to edit the .htaccess"
sudo chmod 660 .htaccess
# 660 is necessary for installing/setting up the plugins at first installation
# 440 is used to prevent modification to .htaccess

echo "  - Edit the permalink settings to: Post name"
echo "  - Trash the sample page"
echo "  - Trash the sample post"

#Remove the text files containing the version number of plugins and themes
cd ..
sudo find -type f -name "*.txt" -delete
echo "From the browser, do the following:"

# Move back public_html folder to be able to run wp-cli commands
cd public_html

# Themes commands
#
# https://developer.wordpress.org/cli/commands/theme/
wp scaffold child-theme asteol --parent_theme=twentynineteen --theme_name='Asteol Theme' --author="Puzzlout" --author_uri=http://puzzlout.com --theme_uri=http://puzzlout.com


# Plugins commands
#
# https://developer.wordpress.org/cli/commands/plugin/

wp plugin delete hello
wp plugin install wp-super-cache
wp plugin install better-wp-security
#wp plugin install all-in-one-seo-pack
#wp plugin install social-media-feather
#wp plugin install add-from-server
#wp plugin install multiple-sidebars
#wp plugin install jetpack
wp plugin activate --all


cd