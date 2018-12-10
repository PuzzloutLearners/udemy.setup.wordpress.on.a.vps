#!/bin/sh

cd

sudo apt-get install fail2ban
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/8.fail2ban/assets/jail.local jail.local
cd jail.d/
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/8.fail2ban/assets/defaults-debian.conf defaults-debian.conf
sudo systemctl restart fail2ban
sudo cp defaults-debian.conf defaults-debian.conf.custom

# If you use WP Scan, you will need to stop fail2ban service using the following commande
# sudo service fail2ban stop
#
# Don't forget to restart it when you are done
# sudo service fail2ban start
