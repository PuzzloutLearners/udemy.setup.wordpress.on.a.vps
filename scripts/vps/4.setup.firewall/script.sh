#!/bin/sh

sudo iptables -L
# No rules are active.

sudo nano /etc/iptables.firewall.rules
# Copy the content of the asset file "firewall-rules.txt" into "iptables.firewall.rules"

sudo iptables-restore < /etc/iptables.firewall.rules

sudo nano /etc/network/if-pre-up.d/firewall
# Copy the content of the asset file "firewall-reboot.txt" into the file "firewall"
sudo chmod +x /etc/network/if-pre-up.d/firewall

exit

# Reboot and run the following command:
sudo iptables -L

# The rules must be active.
