#!/bin/sh

cd
cd /etc/mysql/mysql.conf.d/
sudo cp mysqld.cnf mysqld.cnf.bak
mysqlcheck -u puzzlout -p --all-databases
# If the above command gives only OK, the following command is not necessary. 
# To check: every week.

mysqlcheck -o -u puzzlout -p --all-databases
# During the execution of the above command, each table is locked (no update, create or delete).

cd
mkdir mysql_tuner
cd mysql_tuner
wget http://mysqltuner.pl/ -O mysqltuner.pl
chmod +x mysqltuner.pl
./mysqltuner

cd /etc/mysql/mysql.conf.d/
sudo nano mysqld.cnf
# Add, after "Query Cache Configuration" section, a new section

# My customizations
# innodb_log_file_size    = 32M or 16M depending on the recommandations for this variable
# skip-name-resolve=1

sudo systemctl restart mysql

# Run once a week only:
#	cd mysql_tuner
#	./mysqltuner.pl

