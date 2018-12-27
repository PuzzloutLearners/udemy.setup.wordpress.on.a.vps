#!/bin/bash

# Install 
sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt

# Setup the cron task
echo '@weekly root cd /opt/letsencrypt && git pull >> /var/log/letsencrypt/letsencrypt-auto-update.log' | sudo tee --append /etc/crontab