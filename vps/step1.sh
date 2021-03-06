#!/bin/bash
clear
repodir="vpsinstaller"

git config --global push.default simple
git config --global credential.helper 'store --file ~/.my-credentials'
git config --global user.name "Jeremie Litzler"
git config --global user.email puzzlout@gmail.com

git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps $repodir

# vps/1.check.updates/script.sh
echo "Download and install all packages to update"
sudo apt-get -qq update && sudo apt-get -qq upgrade && sudo apt-get -qq dist-upgrade

username="puzzlout"
bash $repodir/vps/2.add.new.admin.user/script.sh $username $repodir
echo "Setup environnement of new admin user..."
su $username
cd
# Create a .ssh dir to enable better security with SSH key pair
mkdir .ssh
repodir="vpsinstaller"
git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps $repodir
ls -l
logout 
echo "Environnement of new admin user ready."
echo "Now, copy the public ssh key to the server"
logout