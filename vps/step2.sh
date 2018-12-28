#!/bin/bash

git config --global push.default simple
git config --global credential.helper 'store --file ~/.my-credentials'
git config --global user.name "Jeremie Litzler"
git config --global user.email puzzlout@gmail.com


repodir="vpsinstaller"
bash $repodir/vps/3.secure.ssh.dir/script.sh 
sudo cp $repodir/vps/3.secure.ssh.dir/assets/authorized_keys .ssh/
sudo chown puzzlout:puzzlout .ssh/authorized_keys

logout