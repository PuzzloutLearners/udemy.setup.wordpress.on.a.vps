#!/bin/bash
clear
repodir="vpsinstaller"

git config --global credential.helper 'store --file ~/.my-credentials'
git config --global user.name "Jeremie Litzler"
git config --global user.email puzzlout@gmail.com

git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps $repodir

bash $repodir/scripts/vps/1.check.updates/script.sh

username="puzzlout"
bash $repodir/scripts/vps/2.add.new.admin.user/script.sh $username $repodir
echo "Setup environnement of new admin user..."
su $username
cd
# Create a .ssh dir to enable better security with SSH key pair
mkdir .ssh

git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps vpsinstaller
ls -l
exit 
echo "Environnement of new admin user ready."

# Login as $username
repodir="vpsinstaller"
bash $repodir/scripts/vps/3.secure.ssh.dir/script.sh

# Login as $username using the SSH key
repodir="vpsinstaller"
bash $repodir/scripts/vps/4.setup.firewall/1.install.sh $repodir

# After reboot
repodir="vpsinstaller"
username="puzzlout"
bash $repodir/scripts/vps/4.setup.firewall/2.check.rules.sh

bash $repodir/scripts/vps/5.setup.apache2/1.install.sh
bash $repodir/scripts/vps/5.setup.apache2/2.configure.sh $username $repodir

bash $repodir/scripts/vps/6.setup.mysql/1.install.sh
bash $repodir/scripts/vps/6.setup.mysql/2.optimize.sh $username $repodir

bash $repodir/scripts/vps/7.setup.php/1.install.sh $username $repodir
bash $repodir/scripts/vps/7.setup.php/2.configure.sh $username $repodir

bash $repodir/scripts/vps/8.setup.fail2ban/install.sh $username $repodir

bash $repodir/scripts/vps/9.setup.mail/script.sh
bash $repodir/scripts/vps/10.setup.monitoring/install.manual.tool.sh

bash $repodir/scripts/web/create.template.conf.sh

domain="asteol.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir
domain="u2.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir
domain="u3.puzzlout.com"
bash $repodir/scripts/web/create.new.site.conf.sh $domain $repodir

bash $repodir/scripts/wp/1.cli/1.install.sh

repodir="vpsinstaller"
# Bug: This doesn't set the constants...
#bash $repodir/scripts/wp/2.create.db/1.set.constants.sh

project_id="asteol"
projecturl="http://$project_id.puzzlout.com"
bash $repodir/scripts/wp/2.create.db/2.set.variables.sh $username $project_id
bash $repodir/scripts/wp/2.create.db/3.run.sql.sh $repodir

projecturl="http://u2.puzzlout.com"
bash $repodir/scripts/wp/2.create.db/2.set.variables.sh $username udemy2
bash $repodir/scripts/wp/2.create.db/3.run.sql.sh $repodir

projecturl="http://u3.puzzlout.com"
bash $repodir/scripts/wp/2.create.db/12.set.variables.sh $username udemy3
bash $repodir/scripts/wp/2.create.db/3.run.sql.sh $repodir