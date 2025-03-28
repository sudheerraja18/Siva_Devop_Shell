#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_FOLDER=$1
DEST_FOLDER=$2
DAYS=${3:-14}

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOGS_FILE="$(echo $0 | awk -F '/' '{print $NF}' | cut -d "." -f1)"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGS_FILE_NAME="$LOGS_FOLDER/$LOGS_FILE-$TIMESTAMP.log"

USAGE(){
    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(Optional)>"
    exit 1
}

mkdir -p "/home/ec2-user/shellscript-logs"
echo "Script started excuting at : $TIMESTAMP" &>>$LOGS_FILE_NAME

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d "$SOURCE_FOLDER" ]
then
    echo "$SOURCE_FOLDER does not exist ... Please check"
    exit 1
fi

if [ ! -d "$DEST_FOLDER" ]
then
    echo "$DEST_FOLDER does not exist ... Please check"
    exit 1
fi

FILES=$(find $SOURCE_FOLDER -name '*.log' -mtime +$DAYS)

if [ -n "$FILES" ]
then
    echo "Files are..... $FILES"
    ZIP_FILE_NAME="$DEST_FOLDER/app-logs-$TIMESTAMP.zip"
    find $SOURCE_FOLDER -name '*.log' -mtime +$DAYS | zip -@ $ZIP_FILE_NAME &>>$LOGS_FILE_NAME
    if [ -f "$ZIP_FILE_NAME" ]
    then
        echo "Successfully created zip file for files older than $DAYS days"
        while read -r filepath
        do
            echo "Deleting file: $filepath"
            rm -rf $filepath
        done <<< $FILES
    else
        echo -e "$R Error:: $N Failed to create ZIP file"
        exit 1
    fi
else
    echo "No files found older than $DAYS days ..."
fi