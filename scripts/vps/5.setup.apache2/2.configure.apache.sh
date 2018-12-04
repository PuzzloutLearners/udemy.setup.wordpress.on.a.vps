#!/bin/sh

cd /etc/apache2/conf-available/

# Backup the security conf file 
sudo cp security.conf security.conf.bak

# Edit the security.conf file
# Modify the value "ServerTokens" from "OS" to "Prod".
# Uncomment the line "ServerSignature off"
# Comment the line "ServerSignature on"

# Restart Apache
sudo service apache2 restart

cd ..

# Backup the general conf file 
sudo cp apache2.conf apache2.conf.bak

# Edit the apache2.conf file
sudo nano apache2.conf

# Add the content of the asset file "mpm_prefork_module.conf" at the end of the apache2.conf file
# At the block "<Directory /var/www/>", modify "AllowOverride" to "All" to enable using .htaccess files

# Disable the auto index module (listing all the files is a security problem)
sudo a2dismod autoindex -f
# Enable the rewrite module
sudo a2enmod rewrite

# Restart Apache
sudo service apache2 restart


