#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error: User need to have super user permission to execute this script"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "Installing mysql.....FAILURE"
        exit 1
    else
        echo "Installing mysql.....SUCCESS"
    fi
else
    echo "mysql package already ....INSTALLED"
fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Installing git.....FAILURE"
        exit 1
    else
        echo "Installing git.....SUCCESS"
    fi
else
    echo "git package already ....INSTALLED"
fi

