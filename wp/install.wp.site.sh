#!/bin/bash
# Input parameters
if [[ $1 == "" ]]
	then
		printf "The unix username that will own the WordPress site is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a ProjectId value. It is used to create the database and the admin user.\n"
		exit 1;
fi
if [[ $3 == "" ]]
	then
		printf "Please provide a directory name of the git repo containing the installer.\n"
		exit 1;
fi
DefaultEmail="puzzlout@gmail.com"
if [[ $4 == "" ]]
	then
		printf "No e-mail address provided. Using $DefaultEmail instead.\n"
		ProjectAdminEmail=$DefaultEmail
fi
if [[ $4 != "" ]]
	then
		ProjectAdminEmail=$4
fi
if [[ $5 == "" ]]
	then
		printf "Please provide a domain value where the website will be available.\n"
		exit 1;
fi

# Constants
MaxRandomStringSizeCommonUsage=6
MaxRandomStringSizePasswordUsage=16

echo $MaxRandomStringSizeCommonUsage
echo $MaxRandomStringSizePasswordUsage

# Variables
UnixUserName=$1
ProjectId=$2
RepositoryDir=$3
ProjectTitle="Project_$ProjectId"

WordPressUserRandomPassword=$(openssl rand -base64 $MaxRandomStringSizePasswordUsage)
WordPressUserPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head $MaxRandomStringSizeCommonUsage)
DatabaseDetailPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head $MaxRandomStringSizeCommonUsage)

# a WordPress admin UserName following this template: {the project id}_{the WordPress admin user prefix}
WordPressAdminUserName="$ProjectIdId"_"$WordPressUserPrefix"
WordPressAdminUserPassword=$WordPressUserRandomPassword
WordPressTablePrefix="$DatabaseDetailPrefix"_
echo $WordPressAdminUnixUserName
echo $WordPressAdminUserPassword
echo $WordPressTablePrefix

FullDomain=$5
FullWebSiteUrl="https://$FullDomain"


cd /var/www/$FullDomain/public_html

wp core download
wp core config --dbname=$dbname --dbuser=$dbuser --dbpass=$dbuserpwd --dbprefix=$WordPressTablePrefix
wp core install --url=$FullWebSiteUrl --title=$ProjectTitle --admin_user=$WordPressAdminUserName --admin_password=$WordPressAdminUserPassword --admin_email=$ProjectAdminEmail

sudo chown -R $UnixUserName:www-data /var/www/$FullDomain
sudo find /var/www -type d -exec chmod 775 {} \;
sudo find /var/www -type f -exec chmod 664 {} \;

mv wp-config.php ../
rm wp-config-sample.php

cd
cat $RepositoryDir/wp/assets/install.wp/wp-config.file.modifications.txt >> /var/www/$FullDomain/wp-config.php

cd /var/www/$FullDomain
sudo chmod 440 wp-config.php

cd public_html

rm index.html
touch .htaccess
sudo chown $UnixUserName:www-data .htaccess
echo "Allow $UnixUserName and webserver to edit the .htaccess"
sudo chmod 660 .htaccess
# 660 is necessary for installing/setting up the plugins at first installation
# 440 is used to prevent modification to .htaccess

echo "  - Edit the permalink settings to: Post name"
echo "  - Trash the sample page"
echo "  - Trash the sample post"

echo "Remove the text files containing the version number of plugins and themes"
cd ..
sudo find -type f -name "*.txt" -delete
echo "From the browser, do the following:"

echo "Move back public_html folder to be able to run wp-cli commands"
cd public_html

# Themes commands
#
# https://developer.wordpress.org/cli/commands/theme/
#wp scaffold child-theme asteol --parent_theme=twentynineteen --theme_name='Asteol Theme' --author="Puzzlout" --author_uri=http://puzzlout.com --theme_uri=http://puzzlout.com

# Plugins commands
#
# https://developer.wordpress.org/cli/commands/plugin/

echo "Remove hello plugin"
wp plugin delete hello
echo "Install WP Super Cache plugin"
wp plugin install wp-super-cache
echo "Installl iThemes security plugin"
wp plugin install better-wp-security
#wp plugin install all-in-one-seo-pack
#wp plugin install social-media-feather
#wp plugin install add-from-server
#wp plugin install multiple-sidebars
#wp plugin install jetpack
echo "Activate all plugins"
wp plugin activate --all

cd
