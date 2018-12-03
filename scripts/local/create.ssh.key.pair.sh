
# $1 => user
# $2 => IP address of server
# $3 => path to id_rsa.pub
# Create the key pair
ssh-keygen -t rsa -b 4096

# Hit return on file name prompt
# Type a passphrase with spaces

# Copy securely the public key to the server
scp /path_to_public_key/id_rsa.pub $1@$2:/home/$1/.ssh

# Type the password
