# Root Login to Mysql
root_mysql_user="puzzlout"

# Constants
max_random_str_size_generic=6
max_random_str_size_pwd=16
project="udemy3"
project_email="puzzlout@gmail.com"
project_url="http://udemy3.puzzlout.com"
project_url="Project 3"

# Variables
db_random_pwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
dbdetailprefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

wp_user_random_pwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_pwd};echo;)
wp_user_prefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$max_random_str_size_generic};echo;)

dbname="$project.$db_detail_prefix"
dbuser="$project.u.$db_detail_prefix"
dbuserpwd=$random_pwd

wp_adm_user="$project.$wp_user_prefix"
wp_adm_user_pwd=$wp_user_random_pwd
wp_adm_user_email=$project_email
wp_table_prefix="$project.$dbdetailprefix"_

echo $dbname
echo $dbuser
echo $dbuserpwd
echo $wp_adm_user
echo $wp_adm_user_pwd
echo $wp_table_prefix


mysql -u $username -p

# The following are mysql queries
CREATE DATABASE udemy2_7Ph6Uq;
GRANT ALL PRIVILEGES ON udemy2_7Ph6Uq.* TO 'udemy2_u_7Ph6Uq'@'localhost' IDENTIFIED BY 'P9CzxXRpEFaNSkJn';
SHOW GRANTS FOR 'udemy2_u_7Ph6Uq'@'localhost';
FLUSH PRIVILEGES;