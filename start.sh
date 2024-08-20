#!/bin/bash
set -x
. /home/ceir/.bash_profile
build_path="${APP_HOME}/PlatformComponent/"
build="PlatformComponents.jar"
cd $build_path
VAR=""
status=`ps -ef | grep $build | grep java`
if [ "$status" != "$VAR" ]
then
 echo "Process Already Running"
else
 echo "Starting Process"
 java -Dlog4j.configurationFile=./log4j2.xml -Dspring.config.location=file:./application.properties,file:${APP_HOME}/configuration/configuration.properties -jar $build 1>${DATA_HOME}/logs/PlatformComponent/log.txt 2>${DATA_HOME}/logs/PlatformComponent/error.txt &
echo "Process Started"
fi
