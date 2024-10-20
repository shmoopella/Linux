#!/bin/bash

. ./check.sh
. ./create.sh

path=$1
count_d=$2
dir_letters=$3
count_f=$4
file_letters=$5
file_size=$6
count_param=$#

chmod +x check.sh create.sh

check $path $count_d $dir_letters $count_f $file_letters $file_size $count_param
creation_directory_with_files

#find $1 -type d -cmin -1 -ls | awk '{printf "%s %s%s %s\n", $11, $9, $8, $10}' > info.log #create log for directory
#find $1 -type f -cmin -1 -ls | awk '{printf "%s %s%s %s %sKb\n", $11, $9, $8, $10, $7}' >> info.log #create log for files