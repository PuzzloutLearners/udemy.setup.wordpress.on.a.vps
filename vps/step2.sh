#!/bin/bash

repodir="vpsinstaller"
bash $repodir/vps/3.secure.ssh.dir/script.sh 
sudo cp $repodir/vps/3.secure.ssh.dir/assets/authorized_keys .ssh/
sudo chown puzzlout:puzzlout .ssh/authorized_keys

logout