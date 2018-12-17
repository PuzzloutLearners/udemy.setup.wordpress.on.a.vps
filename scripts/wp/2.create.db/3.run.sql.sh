#!/bin/bash

if [[ $1 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
vpsinstallerdir=$1

wpdbpreparedir="wp.db.prepare"
mkdir $wpdbpreparedir
cd

templatesqlfile="db.create.template.sql"
projectsqlfile="db.create.$project.sql"

cp $vpsinstallerdir/scripts/wp/2.create.db/assets/$templatesqlfile $wpdbpreparedir/$projectsqlfile

cd $wpdbpreparedir

sed -i -e 's:dbname:'$dbname':g' $projectsqlfile
sed -i -e 's:dbusername:'$dbuser':g' $projectsqlfile
sed -i -e 's:dbuserpwd:'$dbuserpwd':g' $projectsqlfile

mysql -u $root_mysql_user -p < $projectsqlfile

cd