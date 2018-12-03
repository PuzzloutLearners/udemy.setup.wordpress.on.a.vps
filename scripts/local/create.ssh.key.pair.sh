
# $1 => user
# $2 => IP address of server
# $3 => path to id_rsa.pub
# Create the key pair
ssh-keygen -t rsa -b 4096

# Hit return on file name prompt
# Type a passphrase with spaces

# Copy securely the public key to the server
scp $3id_rsa.pub $1@$2:/home/$1/.ssh

# Type the password
