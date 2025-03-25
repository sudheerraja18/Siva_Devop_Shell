#!/bin/bash

MSG="SCRIPT-1"
GREET="Hi from Script-1"
source ./22_script_2.sh

echo "Hello from: $MSG"
echo "A value: $A"

##################Method -2###########################

# MSG="SCRIPT-1"
# GREET="Hi from Script-1"

# echo "Hello from: $MSG"
# sh 22_script_2.sh