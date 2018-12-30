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
if [[ "$4" != "$ModeProd" ]]
	then
		printf "Running the script in Debug mode.\n"
fi

echo "Defining RootMysqlUser"
RootMysqlUser=$1
echo "Defining ProjectId"
ProjectId=$2
echo "Defining InstallerRepositoryDir"
InstallerRepositoryDir=$3

# Constants
# Directory name where the project files are stored and versioned.
ProjectRepoDir="ProjectRepository.Files"
# Filename to store the project information
ProjectInformationFilename="KeyInformation.md"
# Argument to pass to the random string generator to define the max size of the output string.
MaxRandomStringSizeCommonUsage="-c6"
# Max size the randomly generated password.
MaxRandomStringSizePasswordUsage=16
OutputStringSeperator=";"

echo "MaxRandomStringSizeCommonUsage equals to $MaxRandomStringSizeCommonUsage"
echo "MaxRandomStringSizePasswordUsage equals to $MaxRandomStringSizePasswordUsage"

# Variables
echo "Create the Database password"
DatabaseRandomPassword=$(openssl rand -base64 $MaxRandomStringSizePasswordUsage)
echo "DatabaseRandomPassword is: $DatabaseRandomPassword"
echo "Create the Database prefix"
DatabaseDetailPrefix=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head $MaxRandomStringSizeCommonUsage)
echo "DatabaseDetailPrefix is: $DatabaseDetailPrefix"

DatabaseName="$ProjectId"_"$DatabaseDetailPrefix"
DatabaseUsername="$ProjectId"_u_"$DatabaseDetailPrefix"
echo $DatabaseName
echo $DatabaseUsername
echo $DatabaseRandomPassword

ProjectFilesDir="$ProjectRepoDir/$ProjectId"
if [ ! -d "$ProjectFilesDir" ]
  then
	echo "Creating $ProjectFilesDir directory"
    git clone https://gitlab.com/asteol-project/Project.Files $ProjectRepoDir
  else
	echo "$ProjectFilesDir directory already exist..."
fi
# Check the KeyInformation file for ProjectId in the repository exists
if [ ! -e "$ProjectFilesDir/$ProjectInformationFilename"  ]
  then
    echo "Creating the file $ProjectFilesDir/$ProjectInformationFilename file"
    touch $ProjectFilesDir/$ProjectInformationFilename
  else
	echo "$ProjectFilesDir/$ProjectInformationFilename file already exist..."
fi

# Add to KeyInformation file all the details.
echo "DbName $OutputStringSeperator $DatabaseName" >> $ProjectFilesDir/$ProjectInformationFilename
echo "DbUsername $OutputStringSeperator $DatabaseUsername" >> $ProjectFilesDir/$ProjectInformationFilename
echo "DbUserPassword $OutputStringSeperator $DatabaseRandomPassword" >> $ProjectFilesDir/$ProjectInformationFilename

cd

# Prepare the SQL file
#InstallerRepositoryDir=vpsinstaller
if [ "$Mode" == "$ModeProd" ]
	then
		mkdir $ProjectRepoDir/$ProjectId

		TemplateDbCreationFilename="db.create.template.sql"
		ProjectWordPressDbCreationFilename="db.create.$ProjectId.sql"

		cd #to make you are in Home dir of the connected UNIX user
		cp $InstallerRepositoryDir/wp/assets/manage.db/$TemplateDbCreationFilename $ProjectRepoDir/$ProjectId/$ProjectWordPressDbCreationFilename

		cd $ProjectRepoDir/$ProjectId

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
