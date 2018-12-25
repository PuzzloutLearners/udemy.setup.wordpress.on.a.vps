#!/bin/bash

# Input parameters
if [[ $1 == "" ]]
	then
		printf "Please provide the WordPress site domain.\n"
		exit 1;
fi

domain=$1
backup_archive_filename=$domain.$(date -d "today" +"%Y%m%d%H%M%S").tar.gz
sites_backups_dir="sites_backups"

# Create a directory to store the all backups
mkdir $sites_backups_dir

# Tar variables are as follows:
# c = Create a new archive.
# z = Compress automatically.
# v = List all files on screen as there are processed.
# f = Specify the filename of the archive.
/bin/tar -czvf $sites_backups_dir/$backup_archive_filename /var/www/$domain
