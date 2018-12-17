#!/bin/bash
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

username=$1
project=$2
# Root Login to Mysql
root_mysql_user=$username

projectemail=$defaultemail
projecttitle="Project $project"

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
wptableprefix="$project"_"$dbdetailprefix"_

echo $dbname
echo $dbuser
echo $dbuserpwd
echo $wpadmuser
echo $wpadmuserpwd
echo $wptableprefix