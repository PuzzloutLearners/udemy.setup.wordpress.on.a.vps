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

cd
