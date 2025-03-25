#!/bin/bash

source ./common.sh

SOURCE_FOLDER="/home/ec2-user/app-logs"
echo "Script started excuting at : $TIMESTAMP" &>>$LOGS_FILE_NAME

FILES_TO_DELETE=$(find $SOURCE_FOLDER -name '*.log' -mtime +14)
echo "Files to be deleted: $FILES_TO_DELETE"

while read -r file
do
    echo "Deleting file: $file"
    rm -rf $file
done <<< $FILES_TO_DELETE

