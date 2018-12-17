#!/bin/bash

# Browse to the home dir of the user
cd 

# Create a .ssh dir to enable better security with SSH key pair
mkdir .ssh

# Browse to .ssh dir
cd .ssh/

# Create a file to store the authorized ssh public keys
touch authorized_keys

# Copy the content of the public key file into authorized_keys 
read -n1 -rsp $'Copy the id_rsa.pub file to the VPS before continuing. Press any to continue when it is done...\n'

cat id_rsa.pub >> authorized_keys

# Remove the public key file
rm id_rsa.pub

# Then, tighten the permissions of the file authorized_keys
# Only the owner can read
sudo chmod 400 authorized_keys

# And tighten the permissions of the .ssh folder
# Only the owner can read/write/execute
cd ..
sudo chmod 700 .ssh

# Allow only the root and owner to make modifications to .ssh folder
# It is setting an imutable bit on the directory
sudo chattr +i .ssh

# If the above line doesn't work, install the package
# sudo apt-get install e2fsprogs

# Let's now configure the server to accept only SSH key pairs to login
cd
sudo sed -i -e 's:#AuthorizedKeysFile:AuthorizedKeysFile:g' /etc/ssh/sshd_config
sudo sed -i -e 's:PasswordAuthentication yes:PasswordAuthentication no:g' /etc/ssh/sshd_config
sudo nano /etc/ssh/sshd_config

# Uncomment the line "#AuthorizedKeysFile     %h/.ssh/authorized_keys"
# Under "Change to no to disable tunnelled clear text passwords", set no to "PasswordAuthentication"

# Finally restart ssh
sudo service ssh restart

echo "Log in to the vps. You should be asked the passphrase of the public key."
exit
