#!/bin/bash

. ./check.sh
. ./create.sh

SCRIPT_START=$(date +"%H:%M:%S %d.%m.%y")
echo "Script started: $SCRIPT_START" >> info.log

dir_letters=$1
file_letters=$2
file_size=$3
count_param=$#

chmod +x check.sh create.sh

if check $dir_letters $file_letters $file_size $count_param
then
    creation_directory_with_files

SCRIPT_END=$(date +"%H:%M:%S %d.%m.%y")

echo "Script started: $SCRIPT_START"
echo "Script ended: $SCRIPT_END" >> info.log
echo "Script ended: $SCRIPT_END"

fi 
# find -type d -cmin -20 -ls | awk '{printf "%s %s%s %s\n", $11, $9, $8, $10}' > info.log #посмотреть последние измененные директории за определенное время
# find -type f -cmin -20 -ls | awk '{printf "%s %s%s %s %sKb\n", $11, $9, $8, $10, $7}' >> info.log #посмотреть последние измененные файлы за определенное время