# Root Login to Mysql
root_mysql_user="puzzlout"

# Constants
max_random_str_size_generic=6
max_random_str_size_pwd=16
project="udemy"
projectemail="puzzlout@gmail.com"
projecturl="http://udemy.puzzlout.com"
projecttitle="Project 1"

# Variables
dbrandompwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
dbdetailprefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

wpuserrandompwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
wpuserprefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

dbname="$project"_"$dbdetailprefix"
dbuser="$project"_u_"$dbdetailprefix"
dbuserpwd=$dbrandompwd

wpadmuser="$project"_"$wpuserprefix"
wpadmuserpwd=$wpuserrandompwd
wpadmuseremail=$projectemail
wptableprefix="$project"_"$dbdetailprefix"_

echo $dbname
echo $dbuser
echo $dbuserpwd
echo $wpadmuser
echo $wpadmuserpwd
echo $wptableprefix

mkdir wp.db.prepare
cd wp.db.prepare
templatesqlfile="db.create.template.sql"
projectsqlfile="db.create.$project.sql"
cp ../udemy.setup.wordpress.on.a.vps/scripts/wp/1.cli/assets/$templatesqlfile $projectsqlfile

sed -i -e 's:dbname:'$dbname':g' $projectsqlfile
sed -i -e 's:dbusername:'$dbuser':g' $projectsqlfile
sed -i -e 's:dbuserpwd:'$dbuserpwd':g' $projectsqlfile

mysql -u $root_mysql_user -p < $projectsqlfile