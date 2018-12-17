#!/bin/sh

if [[ $1 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
vpsinstaller=$1
sudo iptables -L
# No rules are active.

sudo cp $vpsinstaller/scripts/vps/4.setup.firewall/assets/firewall-rules.txt /etc/iptables.firewall.rules
# Copy the content of the asset file "firewall-rules.txt" into "iptables.firewall.rules"

sudo iptables-restore < /etc/iptables.firewall.rules

sudo cp $vpsinstaller/scripts/vps/4.setup.firewall/assets/firewall-reboot.txt /etc/network/if-pre-up.d/firewall
# Copy the content of the asset file "firewall-reboot.txt" into the file "firewall"
sudo chmod +x /etc/network/if-pre-up.d/firewall
sudo reboot
