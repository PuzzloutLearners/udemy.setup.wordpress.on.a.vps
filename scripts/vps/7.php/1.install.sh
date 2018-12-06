
#!/bin/sh

cd

sudo apt-get install php libapache2-mod-php php-mcrypt php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
php -v

cd /etc/php/7.0/apache2/
sudo cp php.ini php.ini.bak
cd /var/www/html/
sudo nano info.php
# Paste phpinfo(); in the file
# Check the page in the browser

# Finally, remove the file.
sudo rm info.php
