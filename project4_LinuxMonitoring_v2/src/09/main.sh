#!/bin/bash

while true
do
    > /data/metrics/index.html
    IDLE_TIME=$(cat /proc/stat | grep cpu | awk 'NR==1{print $5}')
    TOTAL_TIME=$(cat /proc/stat | grep cpu | awk 'NR==1 {print $2+$3+$4+$5+$6+$7+$8+$9+$10}')
    #CPU_USAGE=$(echo "scale=2; 100 * ($TOTAL_TIME - $IDLE_TIME) / $TOTAL_TIME" | bc)
    CPU_USAGE=$(echo "$TOTAL_TIME $IDLE_TIME" | awk '{printf "%.3f", 100 * ($1 - $2) / $1}')
    sudo echo "cpu_usage_total $CPU_USAGE" >> /data/metrics/index.html

    USED_RAM="$(free | awk 'NR==2{print $3}')"
    sudo echo "ram_usage_total $USED_RAM" >> /data/metrics/index.html

    DISK_USED="$(df / | awk 'NR==2{print $3}')"
    DISK_FREE="$(df / | awk 'NR==2{print $4}')"
    sudo echo "disk_used_total $DISK_USED" >> /data/metrics/index.html
    sudo echo "disk_available_total $DISK_FREE" >> /data/metrics/index.html
    sleep 3
done