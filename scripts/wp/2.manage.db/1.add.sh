#!/bin/sh
# Input parameters
if [[ $1 == "" ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a project value. Used to create the database and the admin user.\n"
		exit 1;
fi
if [[ $3 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi

# Constants
max_random_str_size_generic=6
max_random_str_size_pwd=16

defaultemail="puzzlout@gmail.com"

echo $max_random_str_size_generic
echo $max_random_str_size_pwd
echo $defaultemail

# Variables

username=puzzlout
project=asteol
# Root Login to Mysql
root_mysql_user=$username

projectemail=$defaultemail
projecttitle="Project_$project"

# Variables
dbrandompwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
dbdetailprefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

wpuserrandompwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
wpuserprefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

dbname="$project"_"$dbdetailprefix"
dbuser="$project"_u_"$dbdetailprefix"
dbuserpwd=$dbrandompwd

wpadmuser="$project"_"$wpuserprefix"
wpadmuserpwd=$wpuserrandompwd
wpadmuseremail=$projectemail
wptableprefix="$dbdetailprefix"_

echo $dbname
echo $dbuser
echo $dbuserpwd
echo $wpadmuser
echo $wpadmuserpwd
echo $wptableprefix

# Prepare the SQL file
vpsinstallerdir=vpsinstaller

wpdbpreparedir="wp.db.prepare"
mkdir $wpdbpreparedir
cd

templatesqlfile="db.create.template.sql"
projectsqlfile="db.create.$project.sql"

cp /home/$username/$vpsinstallerdir/scripts/wp/2.manage.db/assets/$templatesqlfile $wpdbpreparedir/$projectsqlfile

cd $wpdbpreparedir

sed -i -e 's:dbname:'$dbname':g' $projectsqlfile
sed -i -e 's:dbusername:'$dbuser':g' $projectsqlfile
sed -i -e 's:dbuserpwd:'$dbuserpwd':g' $projectsqlfile

# Run the SQL file

mysql -u $root_mysql_user -p < $projectsqlfile

cd