#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_FOLDER="/home/ec2-user/app-logs"

LOGS_FOLDER="/var/log/shellscript-logs"
LOGS_FILE="$(echo $0 | cut -d "." -f1)"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGS_FILE_NAME="$LOGS_FOLDER/$LOGS_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2..... $R FAILURE $N"
        exit 1
    else
        echo -e "$2..... $G SUCCESS $N"
    fi
}

echo "Script started excuting at : $TIMESTAMP" &>>$LOGS_FILE_NAME

FILES_TO_DELETE=$(find $SOURCE_FOLDER -name '*.log' -mtime +14)
echo "Files to be deleted: $FILES_TO_DELETE"

while read -r file
do
    echo "Deleting file: $file"
    rm -rf $file
done <<< $FILES_TO_DELETE

