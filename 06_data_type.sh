#!/bin/bash

Number1=$1
Number2=$2

TIMESTAMP=$(date)
echo "Script executed at: $TIMESTAMP"

SUM=$(($Number1+$Number2))
echo "Sum of $Number1 and $Number is $SUM"