
# $1 => user
# $2 => IP address of server
# $3 => path to id_rsa.pub
# Create the key pair
mkdir .ssh
ssh-keygen -t rsa -b 4096

# Hit return on file name prompt
# Type a passphrase with spaces

user="puzzlout"
ip="172.104.155.53"
# Copy securely the public key to the server
scp .ssh/id_rsa.pub $user@$ip:/home/$user/.ssh

# Type the password
