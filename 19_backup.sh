#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_FOLDER=$1
DEST_FOLDER=$2
DAYS=${3:-14}

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOGS_FILE="$(echo $0 | cut -d "." -f1)"
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
    echo "source folder does not exist ..."
    exit 1
fi

if [ ! -d "$DEST_FOLDER" ]
then
    echo "destination folder does not exist ..."
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_FOLDER -name '*.log' -mtime +14)

if [ -n "$FILES_TO_DELETE" ]
then
    echo "Files to be deleted are....."
    echo "$FILES_TO_DELETE"
    find . -name '*.log' -mtime +14 | zip -@ $LOGS_FILE_NAME
    if [ $? -eq 0 ]
    then
        while read -r file
        do
            echo "Deleting file: $file"
            # rm -rf $file
        done <<< $FILES_TO_DELETE
    else
        echo "Unable to zip the old logs"
    fi
else
    echo "No files to zip"
fi