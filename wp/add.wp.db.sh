#!/bin/sh
# Input parameters
if [[ $1 == "" ]]
	then
		printf "The unix user is required.\n"
		exit 1;
fi
if [[ $2 == "" ]]
	then
		printf "Please provide a ProjectId value. Used to create the database and the admin user.\n"
		exit 1;
fi
if [[ $3 == "" ]]
	then
		printf "Please provide a value to clone the git repo containing the installer.\n"
		exit 1;
fi
Mode="debug"
if [[ $4 == "" ]]
	then
		printf "Running the script in Production mode.\n"
		Mode="prod"
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
if [[ $Mode == "prod" ]]
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