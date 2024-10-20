#!/bin/bash

count_param=$#
param=$1

check() {
    if [[ $1 -ne 1 ]]
    then
        echo "Incorrect input! Run the script using 1 parameter."
        exit 1
    elif [[ $2 -lt 1 || $2 -gt 4 ]]
    then 
        echo "Incorrect input! The parameter can be only a number: 1 or 2 or 3 or 4"
        exit 2
    fi
}

filtering() {
    if [[ $1 -eq 1 ]]
    then
        awk '{print $0 | "sort -k9"}' ../04/1.log ../04/2.log ../04/3.log ../04/5.log >> code_sort.txt
    
    elif [[ $1 -eq 2 ]]
    then
        awk '{print $1 | "sort -u" }' ../04/1.log ../04/2.log ../04/3.log ../04/5.log >> ip_sort.txt
    
    elif [[ $1 -eq 3 ]]
    then
        awk '$9 ~/^[4-5]0[0-4]$/' ../04/1.log ../04/2.log ../04/3.log ../04/5.log  >> error_sort.txt
    elif [[ $1 -eq 4 ]]
    then
        awk '$9 ~/^[4-5]0[0-4]$/' ../04/1.log ../04/2.log ../04/3.log ../04/5.log | awk '{print $1 | "sort -u" }' >> ip_error_sort_txt
    fi
}

check $count_param $param
filtering $param

