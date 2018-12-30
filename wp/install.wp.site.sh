#!/bin/bash
# Input parameters
# Unix username
if [[ $1 == "" ]]
	then
printf "The unix username that will own the WordPress site is required.\n"
exit 1;
fi
# Project id
if [[ $2 == "" ]]
	then
printf "Please provide a ProjectId value. It is used to create the database and the admin user.\n"
exit 1;
fi
# Directory containing the installer
if [[ $3 == "" ]]
	then
printf "Please provide a directory name of the git repo containing the installer.\n"
exit 1;
fi
# Wordpress Admin e-mail
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
# Full domain name
if [[ $5 == "" ]]
	then
printf "Please provide a domain value where the website will be available.\n"
exit 1;
fi
ModeDebug="debug"
ModeProd="prod"
Mode=$ModeDebug
#If Mode input 
if [[ "$6" == "$ModeProd" ]]
	then
printf "Running the script in Production mode.\n"
Mode=$ModeProd
fi
if [[ "$6" == "" ]]
	then
printf "Running the script in Debug mode.\n"
fi

# Constants
# Directory name where the project files are stored and versioned.
ProjectRepoDir="ProjectRepository.Files"
# Filename to store the project information
ProjectInformationFilename="KeyInformation.md"
# Argument to pass to the random string generator to define the max size of the output string.
MaxRandomStringSizeCommonUsage="-c6"
# Max size the randomly generated password.
MaxRandomStringSizePasswordUsage=16
OutputStringSeperator=";"
echo "MaxRandomStringSizeCommonUsage is $MaxRandomStringSizeCommonUsage"
echo "MaxRandomStringSizePasswordUsage is $MaxRandomStringSizePasswordUsage"

# Variables
UnixUserName=$1
ProjectId=$2
RepositoryDir=$3
ProjectTitle="Project_$ProjectId"

WordPressUserRandomPassword=$(openssl rand -base64 $MaxRandomStringSizePasswordUsage)
WordPressUserPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head $MaxRandomStringSizeCommonUsage)
DatabaseDetailPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head $MaxRandomStringSizeCommonUsage)

# a WordPress admin UserName following this template: {the project id}_{the WordPress admin user prefix}
WordPressAdminUserName="$ProjectId"_"$WordPressUserPrefix"
WordPressTablePrefix="$DatabaseDetailPrefix"_

# Check the directory for ProjectId in the repository exists
ProjectFilesDir="$ProjectRepoDir/$ProjectId"
if [ ! -d "$ProjectFilesDir" ]
  then
	echo "Creating $ProjectFilesDir directory"
    mkdir $ProjectFilesDir
  else
	echo "$ProjectFilesDir directory already exist..."
fi
# Check the KeyInformation file for ProjectId in the repository exists
if [ ! -e "$ProjectFilesDir/$ProjectInformationFilename"  ]
  then
    echo "Creating the file $ProjectFilesDir/$ProjectInformationFilename file"
    touch $ProjectFilesDir/$ProjectInformationFilename
  else
	echo "$ProjectFilesDir/$ProjectInformationFilename file already exist..."
fi

# Add to KeyInformation file all the details.
echo "UnixUserName $OutputStringSeperator $UnixUserName" >> $ProjectFilesDir/$ProjectInformationFilename
echo "ProjectId $OutputStringSeperator $ProjectId" >> $ProjectFilesDir/$ProjectInformationFilename
echo "ProjectTitle $OutputStringSeperator $ProjectTitle" >> $ProjectFilesDir/$ProjectInformationFilename
echo "WordPressAdminUserName $OutputStringSeperator $WordPressAdminUserName" >> $ProjectFilesDir/$ProjectInformationFilename
echo "WordPressUserRandomPassword $OutputStringSeperator $WordPressUserRandomPassword" >> $ProjectFilesDir/$ProjectInformationFilename
echo "WordPressTablePrefix $OutputStringSeperator $WordPressTablePrefix" >> $ProjectFilesDir/$ProjectInformationFilename

FullDomain=$5
echo "FullDomain $OutputStringSeperator $FullDomain" >> $ProjectFilesDir/$ProjectInformationFilename
FullWebSiteUrl="https://$FullDomain"
echo "FullWebSiteUrl $OutputStringSeperator $FullWebSiteUrl" >> $ProjectFilesDir/$ProjectInformationFilename

# Declare the dabatase name and user credentials
DbName=""
DbUsername=""
DbUserPassword=""

# Find the database name value
DbNameLine=$(find $ProjectFilesDir/$ProjectInformationFilename -type f -print | xargs grep "DbName")
IFS=" ; " read -ra keyvalue <<< "$DbNameLine"
for element in "${keyvalue[@]}"; do
  if [ $element != "$DbName" ] 
    then
	  DbName=$element
  fi
done
echo "DbName is $DbName"

# Find the database user value
DbUsernameLine=$(find $ProjectFilesDir/$ProjectInformationFilename -type f -print | xargs grep "DbUsername")
IFS=" ; " read -ra keyvalue <<< "$DbUsernameLine"
for element in "${keyvalue[@]}"; do
  if [ $element != "DbUsername" ] 
    then
	  DbUsername=$element
  fi
done
echo "DbUsername is $DbUsername"

# Find the database user password value
DbUserPasswordLine=$(find $ProjectFilesDir/$ProjectInformationFilename -type f -print | xargs grep "DbUserPassword")
IFS=" ; " read -ra keyvalue <<< "$DbUserPasswordLine"
for element in "${keyvalue[@]}"; do
  if [ $element != "DbUserPassword" ] 
    then
	  DbUserPassword=$element
  fi
done
echo "DbUserPassword is $DbUserPassword"

# Test the credentials and run a query to check database exists.
CheckDatabaseExistsQuery="SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$DbName';"
mysql -u $DbUsername -p $DbUserPassword -e $CheckDatabaseExistsQuery

if [ "$Mode" != "$ModeProd" ]
  then
    echo "Check that all is fine up to that point. If all is ok, run the same command with 'prod' parameter"
	cd $ProjectFilesDir
	git reset --hard HEAD
    exit 1;
fi

cd $ProjectFilesDir
git add -A
git commit -m "[bash] add $ProjectInformationFilename"
git push

cd /var/www/$FullDomain/public_html

wp core download
wp core config --dbname=$DbName --dbuser=$DbUsername --dbpass=$DbUserPassword --dbprefix=$WordPressTablePrefix
wp core install --url=$FullWebSiteUrl --title=$ProjectTitle --admin_user=$WordPressAdminUserName --admin_password=$WordPressUserRandomPassword --admin_email=$ProjectAdminEmail

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