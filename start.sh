#!/bin/bash


module_name="api_internal"
main_module="api_service" #keep it empty "" if there is no main module 
log_level="INFO" # INFO, DEBUG, ERROR


. /home/ceir/.bash_profile
build_path="${APP_HOME}/api_service/api_internal"
build="${module_name}.jar"

cd $build_path
VAR=""

status=`ps -ef | grep $build | grep java`
if [ "$status" != "$VAR" ]
then
 echo "Process Already Running"
else
 echo "Starting Process"
 java -Dlog.level=${log_level} -Dlog.path=${log_path} -Dmodule.name=${module_name}   -Dlog4j.configurationFile=./log4j2.xml -Dspring.config.location=file:./application.properties,file:${commonConfigurationFile} -jar $build 1> /dev/null  2>${LOG_HOME}/api_service/api_internal/error.log & 
echo "Process Started"
fi
