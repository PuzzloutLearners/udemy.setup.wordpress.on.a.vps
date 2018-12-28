#!/bin/bash
repodir=vpsinstaller
username="puzzlout"
domain1="asteoldev.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain1 $repodir $username
bash $repodir/web/enable.ssl.sh $domain1
echo "Try to view https://$domain1 in the browser!"

domain2="asteolformation.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain2 $repodir $username
bash $repodir/web/enable.ssl.sh $domain2
echo "Try to view https://$domain2 in the browser!"

domain3="asteolstaging.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain3 $repodir $username
bash $repodir/web/enable.ssl.sh $domain3
echo "Try to view https://$domain3 in the browser!"