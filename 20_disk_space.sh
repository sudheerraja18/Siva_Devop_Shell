#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r line
do 
    USAGE=$(echo "$line" | awk -F " " '{print $6F}' | cut -d '%' -f1)
    PARTITION=$(echo "$line" | awk -F " "  '{print $7F}')
    if [ $USAGE -gt 5]
    then
        echo "Partition: $PARTITION , USAGE: $USAGE"
    do 
done <<< $DISK_USAGE
