sudo apt-get update
sudo apt-get upgrade
adduser puzzlout
usermod -a -G adm puzzlout

visudo

# Under "User privilege specification", add the following line
# puzzlout  ALL=(ALL:ALL) ALL
#
# CTRL + X then Y then Enter
cd /etc/ssh
# Under "Authentication", update PermitRootLogin to no
nano sshd_config
service ssh restart
exit

# Connect to VPS
cd 
git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps
mkdir .ssh
cd .ssh/
touch authorized_keys
# If using CodeAnywhere
nano id_rsa.pub
cat id_rsa.pub >> authorized_keys
rm id_rsa.pub
sudo chmod 400 authorized_keys
cd ..
sudo chmod 700 .ssh
sudo chattr +i .ssh
cd /etc/ssh/
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/3.security.ssh.dir/assets/sshd_config.txt /etc/ssh/sshd_config
# Uncomment the line "#AuthorizedKeysFile     %h/.ssh/authorized_keys"
# Under "Change to no to disable tunnelled clear text passwords", set no to "PasswordAuthentication"

sudo service ssh restart
exit

# Connect to VPS

git config --global credential.helper 'store --file ~/.my-credentials'
git config --global user.name "Jeremie Litzler"
git config --global user.email puzzlout@gmail.com

sudo iptables -L
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/4.setup.firewall/assets/firewall-rules.txt /etc/iptables.firewall.rules
# Copy the content of the asset file "firewall-rules.txt" into "iptables.firewall.rules"

sudo iptables-restore < /etc/iptables.firewall.rules

sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/4.setup.firewall/assets/firewall-reboot.txt /etc/network/if-pre-up.d/firewall
#sudo nano /etc/network/if-pre-up.d/firewall
# Copy the content of the asset file "firewall-reboot.txt" into the file "firewall"
sudo chmod +x /etc/network/if-pre-up.d/firewall

exit

# Connect to VPS

sudo iptables -L

sudo apt-get install apache2
sudo rm /var/www/html/index.html

# Create a new one from the file "new.index.html"
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/new.index.html /var/www/html/index.html
cd /etc/apache2/conf-available/
sudo cp security.conf security.conf.bak
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/security.conf security.conf
# Modify the value "ServerTokens" from "OS" to "Prod".
# Uncomment the line "ServerSignature off"
# Comment the line "ServerSignature on"

sudo service apache2 restart
cd ..
sudo cp apache2.conf apache2.conf.bak
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/apache2.conf apache2.conf
# Add the content of the asset file "mpm_prefork_module.conf" at the end of the apache2.conf file
# At the block "<Directory /var/www/>", modify "AllowOverride" to "All" to enable using .htaccess files

sudo a2dismod autoindex -f
sudo a2enmod rewrite
sudo service apache2 restart

cd
sudo apt-get install mysql-server php-mysql
sudo mysql_secure_installation

mysql -u root -p

# Type the root password

# Rename the root user
# SQL commands :
#
rename user `root`@`localhost` to `puzzlout`@`localhost`;
flush privileges;
flush privileges;
exit

mysql -u puzzlout -p

exit

cd
cd /etc/mysql/mysql.conf.d/
sudo cp mysqld.cnf mysqld.cnf.bak
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/6.mysql/assets/mysqld.cnf mysqld.cnf

sudo systemctl restart mysql

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
./mysqltuner.pl

#cd /etc/mysql/mysql.conf.d/
#sudo nano mysqld.cnf
# Add, after "Query Cache Configuration" section, a new section

# My customizations
# innodb_log_file_size    = 16M
# skip-name-resolve=1

sudo systemctl restart mysql

# Run once a week only:
#	cd mysql_tuner
#	./mysqltuner.pl

# Php
sudo apt-get install php libapache2-mod-php php-mcrypt php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
php -v

cd /etc/php/7.0/apache2/
sudo cp php.ini php.ini.bak
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/7.php/assets/php.ini.optimized php.ini

cd /var/www/html/
sudo nano info.php
# Paste phpinfo(); in the file
# Check the page in the browser
# Finally, remove the file.
sudo rm info.php

cd /etc/apache2/mods-available/
sudo cp dir.conf dir.conf.bak
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/7.php/assets/dir.conf dir.conf

# Swap index.php and index.html

sudo service apache2 restart

sudo apt-get install fail2ban
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/8.fail2ban/assets/jail.local jail.local
cd jail.d/
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/8.fail2ban/assets/defaults-debian.conf defaults-debian.conf
sudo systemctl restart fail2ban
sudo cp defaults-debian.conf defaults-debian.conf.custom

cd
cd /var/www
domain=udemy.puzzlout.com
sudo mkdir -p $domain/public_html 
cd /etc/apache2/sites-available/
sudo cp 000-default.conf $domain.conf
# https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sudo sed -i -e 's:ServerAdmin webmaster@localhost:ServerAdmin puzzlout@gmail.com:g' $domain.conf
sudo sed -i -e 's:DocumentRoot /var/www/html:DocumentRoot /var/www/$domain/public_html:g' $domain.conf
sudo sed -i '/ServerAdmin/i\
        ServerName '$domain'
' $domain.conf
sudo sed -i '/ServerAdmin/i\
        ServerAlias www.'$domain'
' $domain.conf
sudo a2ensite $domain.conf
sudo service apache2 reload
cd 
sudo cp udemy.setup.wordpress.on.a.vps/scripts/vps/5.setup.apache2/assets/new.index.html /var/www/$domain/public_html/index.html
sudo sed -i -e 's:Coming soon:'$domain' website is coming soon:g' /var/www/$domain/public_html/index.html
