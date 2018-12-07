

sudo apt-get install fail2ban
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo cp /home/puzzlout/udemy.setup.wordpress.on.a.vps/scripts/vps/8.fail2ban/assets/jail.local jail.local
sudo systemctl restart fail2ban
