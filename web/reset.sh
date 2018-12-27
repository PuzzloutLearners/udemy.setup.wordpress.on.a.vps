sudo rm -R /var/www/*
domain1="asteol.dev.puzzlout.com"
sudo a2dissite $domain1
sudo rm /etc/apache2/sites-available/$domain1.conf
sudo rm /etc/apache2/sites-available/$domain1-le-ssl.conf

domain2="asteol.training.puzzlout.com"
sudo a2dissite $domain2
sudo rm /etc/apache2/sites-available/$domain2.conf

domain3="asteol.mockup.wp.puzzlout.com"
sudo a2dissite $domain3
sudo rm /etc/apache2/sites-available/$domain3.conf
