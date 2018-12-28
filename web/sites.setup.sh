#!/bin/bash
repodir=vpsinstaller
username="puzzlout"
domain1="asteol.dev.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain1 $repodir $username
bash $repodir/web/enable.ssl.sh $domain1
echo "Try to view https://$domain1 in the browser!"

domain2="asteol.training.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain2 $repodir $username
bash $repodir/web/enable.ssl.sh $domain3
echo "Try to view https://$domain2 in the browser!"

domain3="asteol.mockup.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain3 $repodir $username
bash $repodir/web/enable.ssl.sh $domain3
echo "Try to view https://$domain3 in the browser!"