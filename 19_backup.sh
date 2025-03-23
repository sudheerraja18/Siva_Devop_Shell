#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_FOLDER=$1
DEST_FOLDER=$2

LOGS_FOLDER="/var/log/shellscript-logs"
LOGS_FILE="$(echo $0 | cut -d "." -f1)"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGS_FILE_NAME="$LOGS_FOLDER/$LOGS_FILE-$TIMESTAMP.log"

USAGE(){
    echo -e "$R ERROR:: $N Script to be excuted as sh <Script Name> <Source Path> <Destination Path> <Days(Optional)>"
    exit 1
}

echo "Script started excuting at : $TIMESTAMP" &>>$LOGS_FILE_NAME

if [ $# -lt 2 ]
then
    USAGE
fi

if [ -d $SOURCE_FOLDER ]
then
    echo "source folder not present in the location"
    exit 1
fi

if [ -d $DEST_FOLDER ]
then
    echo "dest folder not present in the location"
    exit 1
fi

FILES_TO_DELETE=$(find . -name '*.log' -mtime +14)

if [ -n $FILES_TO_DELETE]
then
    echo "Files to be deleted are....."
    echo "$FILES_TO_DELETE"
    find . -name '*.log' -mtime +14 | zip @ $LOGS_FILE_NAME
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