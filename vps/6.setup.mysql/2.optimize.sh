#!/bin/sh
if [[ $1 == "" ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
username=$1
vpsinstallerdir=$2

cd

updaterootuserfile="update.root.user.sql"
cp $vpsinstallerdir/scripts/vps/6.setup.mysql/assets/$updaterootuserfile /home/$username/$updaterootuserfile
sed -i -e 's:newuser:'$username':g' $updaterootuserfile

# Connect to mysql as root and change the root username
mysql -u root -p < $updaterootuserfile

# Type the root password

# Rename the root user
# SQL commands :
#
# rename user `root`@`localhost` to `puzzlout`@`localhost`;
# flush privileges;

# Try to login as the new root user
mysql -u $username -p

cd
cd /etc/mysql/mysql.conf.d/
sudo cp mysqld.cnf mysqld.cnf.bak
sudo cp /home/$username/$vpsinstallerdir/scripts/vps/6.setup.mysql/assets/mysqld.cnf mysqld.cnf

sudo systemctl restart mysql
mysqlcheck -u $username -p --all-databases
# If the above command gives only OK, the following command is not necessary. 
# To check: every week.

#mysqlcheck -o -u puzzlout -p --all-databases
# During the execution of the above command, each table is locked (no update, create or delete).

cd
mkdir mysql_tuner
cd mysql_tuner
wget http://mysqltuner.pl/ -O mysqltuner.pl
chmod +x mysqltuner.pl
./mysqltuner.pl

#cd /etc/mysql/mysql.conf.d/
#sudo nano mysqld.cnf
# Add, after "Query Cache Configuration" section, a new section

# My customizations
# innodb_log_file_size    = 32M or 16M depending on the recommandations for this variable
# skip-name-resolve=1

#sudo systemctl restart mysql

# Run once a week only:
#	cd mysql_tuner
#	./mysqltuner.pl

cd