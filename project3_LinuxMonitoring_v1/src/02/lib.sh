#!/bin/bash

check() {
    if [ $1 -ne 0 ]
    then
        echo Run without parameters!
        exit 1
    fi
}

myprint() {
    timez=$(date +"%z" | head -c 3)
    echo HOSTNAME = $(hostname)
    echo TIMEZONE = $(cat /etc/timezone) UTC $timez
    echo USER = $(whoami)
    echo OS = $(hostnamectl | grep System | sed -r s/'[^:]+:'/''/)
    echo DATE = $(date +"%d %B %Y %T")
    echo UPTIME = $(uptime -p)
    echo UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')
    echo IP = $(hostname -I | awk '{print $1}')
    echo MASK = $(route | awk 'NR == 4{print $3}')
    echo GATEWAY = $(ip route | grep default | awk '{print $3}')
    tmp_RAM=$(vmstat -s -S k | grep total -m1 | awk '{print $1}')
    echo RAM = $(echo  "$tmp_RAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB
    tmp_uRAM=$(vmstat -s -S k | grep used -m1 | awk '{print $1}')
    echo RAM_USED = $(echo  "$tmp_uRAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB
    tmp_fRAM=$(vmstat -s -S k | grep free -m1 | awk '{print $1}')
    echo RAM_FREE = $(echo  "$tmp_fRAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB
    tmp_root=$(df -B1 / | awk '{print($2)}' | grep -v '1B-blocks')
    echo SPACE_ROOT = $(echo "$tmp_root 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB
    tmp_uroot=$(df -B1 / | awk '{print($3)}' | grep -v 'Used')
    echo SPACE_ROOT_USED = $(echo "$tmp_uroot 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB
    tmp_froot=$(df -B1 / | awk '{print $4}' | grep -v 'Avail')
    echo SPACE_ROOT_FREE = $(echo "$tmp_froot 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB
}

ask_save() {
    echo
    echo Do you want to write data to a file? [Y/N]
    read answer
    if [[ "$answer" = "Y" || "$answer" = "y" ]]
    then 
        name_file=$(date +"%d_%m_%g_%k_%M_%S.status")
        myprint > $name_file
    fi
}