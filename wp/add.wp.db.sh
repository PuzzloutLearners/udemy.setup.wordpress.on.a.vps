#!/bin/bash
# Input parameters
if [[ -z $1 ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
if [[ -z $2 ]]
	then
		printf "Please provide a ProjectId value. Used to create the database and the admin user.\n"
		exit 1;
fi
if [[ -z $3 ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
ModeDebug="debug"
ModeProd="prod"
Mode=$ModeDebug
#If Mode input 
if [[ "$4" == "$ModeProd" ]]
	then
		printf "Running the script in Production mode.\n"
		Mode=$ModeProd
fi
if [[ "$4" == "$ModeProd" ]]
	then
		printf "Running the script in Debug mode.\n"
fi

RootMysqlUser=$1
ProjectId=$2
RepositoryDir=$3

# Constants
MaxRandomStringSizeCommonUsage=6
MaxRandomStringSizePasswordUsage=16

echo $MaxRandomStringSizeCommonUsage
echo $MaxRandomStringSizePasswordUsage

# Variables
DatabaseRandomPassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$MaxRandomStringSizePasswordUsage};echo;)
DatabaseDetailPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$MaxRandomStringSizeCommonUsage};echo;)

DatabaseName="$ProjectId"_"$DatabaseDetailPrefix"
DatabaseUsername="$ProjectId"_u_"$DatabaseDetailPrefix"
echo $DatabaseName
echo $DatabaseUsername
echo $DatabaseRandomPassword


# Prepare the SQL file
#RepositoryDir=vpsinstaller
if [ $Mode == "$ModeProd" ]
	then
		cd
		ProjectRepository="ProjectRepository.Files"
		git clone https://gitlab.com/asteol-project/Project.Files $ProjectRepository
		mkdir $ProjectRepository/$ProjectId

		TemplateDbCreationFilename="db.create.template.sql"
		ProjectWordPressDbCreationFilename="db.create.$ProjectId.sql"

		cd #to make you are in Home dir of the connected UNIX user
		cp $RepositoryDir/wp/assets/manage.db/$TemplateDbCreationFilename $ProjectRepository/$ProjectId/$ProjectWordPressDbCreationFilename

		cd $ProjectRepository/$ProjectId

		sed -i -e 's:dbname:'$DatabaseName':g' $ProjectWordPressDbCreationFilename
		sed -i -e 's:dbusername:'$DatabaseUsername':g' $ProjectWordPressDbCreationFilename
		sed -i -e 's:dbuserpwd:'$DatabaseRandomPassword':g' $ProjectWordPressDbCreationFilename

		# Run the SQL file
		mysql -u $RootMysqlUser -p < $ProjectWordPressDbCreationFilename

		git add -A
		git commit -m "feat: add the sql file for $ProjectId"
		git push
fi
cd