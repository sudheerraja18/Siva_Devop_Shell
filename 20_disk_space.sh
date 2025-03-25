#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r line
do 
    USAGE=$(echo "$line" | awk -F " " '{print $6F}' | cut -d '%' -f1)
    PARTITION=$(echo "$line" | awk -F " "  '{print $7F}')
    if [ $USAGE -gt 5 ]
    then
        MSG+="Partition: $PARTITION , USAGE: $USAGE \n"
    fi
done <<< $DISK_USAGE

echo "$MSG"