sudo rm -R /var/www/*
domain1="asteoldev.puzzlout.com"
sudo a2dissite $domain1
sudo rm /etc/apache2/sites-available/$domain1.conf
sudo rm /etc/apache2/sites-available/$domain1-le-ssl.conf

domain2="asteolformation.puzzlout.com"
sudo a2dissite $domain2
sudo rm /etc/apache2/sites-available/$domain2.conf
sudo rm /etc/apache2/sites-available/$domain2-le-ssl.conf

domain3="asteolstaging.puzzlout.com"
sudo a2dissite $domain3
sudo rm /etc/apache2/sites-available/$domain3.conf
sudo rm /etc/apache2/sites-available/$domain3-le-ssl.conf
