#!/bin/bash

username="puzzlout"
domain="asteol.dev.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain $repodir 
domain="asteol.training.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain $repodir
domain="asteol.mockup.wp.puzzlout.com"
bash $repodir/web/create.new.site.conf.sh $domain $repodir

bash $repodir/wp/setup.sh