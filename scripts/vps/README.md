# How to deploy?

```
sudo apt-get update && apt-get install git

git config --global credential.helper 'store --file ~/.my-credentials'
git config --global user.name "Jeremie Litzler"
git config --global user.email puzzlout@gmail.com

git clone https://github.com/PuzzloutLearners/udemy.setup.wordpress.on.a.vps
bash 1.check.updates/script.sh 
bash 2.new.admin.user/script.sh new_username
bash 3.security.ssh.dir/script.sh
bash 4.setup.firewall/script.sh
bash 5.setup.apache2/1.install.apache.sh
bash 5.setup.apache2/2.configure.apache.sh
```
