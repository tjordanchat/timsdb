function printUsage(){
	echo -e "\tUsage: ./NMadmin.sh command appname earfilename/archivename foldername(optional) version(optional)"	
	echo -e "\tValid Commands: buildear, deploy, undeploy, start, stop, kill, upload"	
	echo -e "\tValid appnames: NotificationManager, NMChannelDistribution, allbw"	
	echo -e "\tWhere earfilename/archivename is the name of EAR file/Archive file."	
	echo -e "\tWhere foldername is the folder to upload the application under."	
	echo -e "\tWhere version is the integer version number (1, 2, etc.)"	
	exit 2
}

#check if no arguments are specified
if [ -z "$1" ]
  then
    echo -e "\n\tERROR: No arguments supplied"
    printUsage
fi

#set the appropriate env variables depending on if its dev, integration, QA, Prod
. ./setenv.sh

APP=$4
VER=$5
HOSTNAME=`/bin/hostname`

echo "*********Starting JetBlue master deployment script... Machine: "$HOSTNAME
echo "COMMAND: " $1  " APPLICATION: " $2 " EAR/Archive: " $3 " FOLDER: " $APP " VERSION: " $VER
case "$1" in
	'buildear')
		echo "***Building EAR..." $2
		case "$2" in
			'NotificationManager')
				$BUILDEAR --propFile $BUILDEAR_TRA -x -a $NM_ALIAS_FILE_PATH -ear $3 -o $NM_OUTPUT_EAR_PATH -p $NM_PROJ_LOCATION
				echo "EAR Built for archive" $2
				;;	
			'NMChannelDistribution')
				$BUILDEAR --propFile $BUILDEAR_TRA -x -a $CDM_ALIAS_FILE_PATH -ear $3 -o $CDM_OUTPUT_EAR_PATH -p $CDM_PROJ_LOCATION
				echo "EAR Built for archive" $2
				;;		
			'allbw')
				$BUILDEAR --propFile $BUILDEAR_TRA -x -a $NM_ALIAS_FILE_PATH -ear $3 -o $NM_OUTPUT_EAR_PATH -p $NM_PROJ_LOCATION
				$BUILDEAR --propFile $BUILDEAR_TRA -x -a $CDM_ALIAS_FILE_PATH -ear $3 -o $CDM_OUTPUT_EAR_PATH -p $CDM_PROJ_LOCATION
				echo "EAR Built for archive" $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;

	'start')
		echo "***Starting Application..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -start -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				echo "Started: " $2
				;;	
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -start -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "Started: " $2
				;;		
			'allbw')
				$APPMANAGE --propFile $APPMANAGE_TRA  -start -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				$APPMANAGE --propFile $APPMANAGE_TRA  -start -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "Started: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;
	'stop')
		echo "***Stopping Application..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -stop -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				echo "Stopped: " $2
				;;	
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -stop -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "Stopped: " $2
				;;		
			'allbw')
				$APPMANAGE --propFile $APPMANAGE_TRA  -stop -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				$APPMANAGE --propFile $APPMANAGE_TRA  -stop -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "Stopped: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;
	'kill')
		echo "***Killing Application..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -kill -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				echo "killed: " $2
				;;	
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -kill -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "killed: " $2
				;;		
			'allbw')
				$APPMANAGE --propFile $APPMANAGE_TRA  -kill -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED
				$APPMANAGE --propFile $APPMANAGE_TRA  -kill -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED
				echo "killed: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;

	'deploy')
		echo "Deploying..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -deploy -ear $3 -deployconfig ./deployconfig-NotificationManager-$ENV-$VER.xml -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deployed: " $2
				;;	
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -deploy -ear $3 -deployconfig ./deployconfig-NMChannelDistribution-$ENV-$VER.xml -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deployed: " $2
				;;
			'allbw')
				echo "Deploying NotificationManager.ear, NMChannelDistribution.ear."
				$APPMANAGE --propFile $APPMANAGE_TRA  -deploy -ear NotificationManager.ear -deployconfig ./deployconfig-NotificationManager-$ENV-$VER.xml -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				$APPMANAGE --propFile $APPMANAGE_TRA  -deploy -ear NMChannelDistribution.ear -deployconfig ./deployconfig-NMChannelDistribution-$ENV-$VER.xml -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deployed: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;

	'upload')
		echo "Uploading..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -upload -ear $3 -deployconfig ./deployconfig-NotificationManager-$ENV.xml -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				echo "Uploaded: " $2
				;;
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -upload -ear $3 -deployconfig ./deployconfig-NMChannelDistribution-$ENV.xml -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "Uploaded: " $2
				;;
			'allbw')
				echo "Uploading NotificationManager.ear, NMChannelDistribution.ear"
				$APPMANAGE --propFile $APPMANAGE_TRA  -upload -ear NotificationManager.ear -deployconfig ./deployconfig-NotificationManager-$ENV.xml -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				$APPMANAGE --propFile $APPMANAGE_TRA  -upload -ear NMChannelDistribution.ear -deployconfig ./deployconfig-NMChannelDistribution-$ENV.xml -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "Uploaded: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;
	'undeploy')
		echo "unDeploying..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -undeploy -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				echo "undeployed: " $2
				;;
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -undeploy -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "undeployed: " $2
				;;
			'allbw')
				$APPMANAGE --propFile $APPMANAGE_TRA  -undeploy -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				$APPMANAGE --propFile $APPMANAGE_TRA  -undeploy -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "undeployed: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac

		;;
	'delete')
		echo "deleting application..." $2
		case "$2" in
			'NotificationManager')
				$APPMANAGE --propFile $APPMANAGE_TRA  -delete -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deleted: " $2
				;;
			'NMChannelDistribution')
				$APPMANAGE --propFile $APPMANAGE_TRA  -delete -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deleted: " $2
				;;
			'allbw')
				$APPMANAGE --propFile $APPMANAGE_TRA  -delete -app $APP/NotificationManager$VER -domain $DOMAIN -cred $CRED -nostart
				$APPMANAGE --propFile $APPMANAGE_TRA  -delete -app $APP/NMChannelDistribution$VER -domain $DOMAIN -cred $CRED -nostart
				echo "deleted: " $2
				;;
			*)
				echo "invalid application specified: " $2	
				printUsage
				;;
		esac
		;;

	*)
		echo -e "\n\tERROR: Invalid command passed\n"
		printUsage
		;;
esac
echo "done executing master script";

