#!/bin/bash
# Inputs :
# $1    =>  the domain name
if [[ $1 == "" ]]
	then
		printf "The domain to install is required.\n"
		exit 1;
fi

echo "Setup SSL over $domain..."
/opt/letsencrypt/letsencrypt-auto --apache --renew-by-default -d $domain
echo "Check the validity dates of SSL certificate of $domain"
sudo openssl x509 -noout -dates -in /etc/letsencrypt/live/$domain/cert.pem

