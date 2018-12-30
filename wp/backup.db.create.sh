#!/bin/bash

# Input parameters
if [[ $1 == "" ]]
	then
		printf "The mysql root user is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a database name value.\n"
		exit 1;
fi
if [[ $3 == "" ]]
	then
		printf "Please provide the WordPress site url.\n"
		exit 1;
fi

# Variables
RootSqlUsername=$1
DbName=$2
FilenameSqlBackup=$3.$(date -d "today" +"%Y%m%d%H%M%S").sql
db_backups_dir=db_backups

# Create a directory to store the all backups
mkdir $db_backups_dir
cd $db_backups_dir

# Backup the database and zip the generated file 
mysqldump -u $RootSqlUsername -p $DbName > $FilenameSqlBackup | gzip -9 > $FilenameSqlBackup.gz

# To unzip:
#  gunzip $FilenameSqlBackup.gz
#  
# To unzip and keep the zipped file:
#  gunzip -k $FilenameSqlBackup.gz