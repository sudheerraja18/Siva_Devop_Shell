#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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

if [ $USERID -ne 0 ]
then
    echo "Error: User need to have super user permission to execute this script"
    exit 1
fi

for package in $@
do
    dnf list installed $package &>>$LOGS_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>>$LOGS_FILE_NAME
        VALIDATE $? "Installing $package"
    else
        echo -e "$package already... $Y installed $N"
    fi
done

