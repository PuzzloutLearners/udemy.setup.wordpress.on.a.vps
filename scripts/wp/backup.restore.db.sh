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
root_sql_username=$1
dbname=$2
backup_sql_filename=$3.$(date -d "today" +"%Y%m%d%H%M%S").sql
