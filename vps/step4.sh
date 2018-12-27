#!/bin/bash
# After reboot
repodir="vpsinstaller"
username="puzzlout"
bash $repodir/vps/4.setup.firewall/2.check.rules.sh

bash $repodir/vps/5.setup.apache2/1.install.sh
bash $repodir/vps/5.setup.apache2/2.configure.sh $username $repodir
sudo nano /etc/apache2/conf-available/security.conf
sudo nano /etc/apache2/apache2.conf

bash $repodir/vps/6.setup.mysql/1.install.sh
bash $repodir/vps/6.setup.mysql/2.optimize.sh $username $repodir

bash $repodir/vps/7.setup.php/1.install.sh $username $repodir
bash $repodir/vps/7.setup.php/2.configure.sh $username $repodir

bash $repodir/vps/8.setup.fail2ban/install.sh $username $repodir

bash $repodir/vps/9.setup.mail/script.sh
bash $repodir/vps/10.setup.monitoring/install.manual.tool.sh

bash $repodir/web/create.template.conf.sh

echo "The vps is setup!"