#!/bin/bash
# After reboot
repodir="vpsinstaller"
username="puzzlout"
bash $repodir/scripts/vps/4.setup.firewall/2.check.rules.sh

bash $repodir/scripts/vps/5.setup.apache2/1.install.sh
bash $repodir/scripts/vps/5.setup.apache2/2.configure.sh $username $repodir
sudo nano /etc/apache2/conf-available/security.conf
sudo nano /etc/apache2/apache2.conf

bash $repodir/scripts/vps/6.setup.mysql/1.install.sh
bash $repodir/scripts/vps/6.setup.mysql/2.optimize.sh $username $repodir

bash $repodir/scripts/vps/7.setup.php/1.install.sh $username $repodir
bash $repodir/scripts/vps/7.setup.php/2.configure.sh $username $repodir

bash $repodir/scripts/vps/8.setup.fail2ban/install.sh $username $repodir

bash $repodir/scripts/vps/9.setup.mail/script.sh
bash $repodir/scripts/vps/10.setup.monitoring/install.manual.tool.sh

bash $repodir/scripts/web/create.template.conf.sh

domain="asteol.dev.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir
domain="asteol.training.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir
domain="asteol.mockup.wp.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir

bash $repodir/scripts/wp/setup.sh