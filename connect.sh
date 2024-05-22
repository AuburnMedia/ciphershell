#!/bin/bash

source ./functions.sh

printf "\r"
displaynotification "The VPN is now connecting. Do not turn off or restart your machine." "Connecting.."
progress-bar 5
for ((n = 1; n <= (RANDOM / 10); n++)); #32767, 327
do
    if [ $n -eq 1 ]; then
        connection_system
    else
        #proceed_connection
        
        echo $(date +"%T") "connecting thread $n to VPN" >> log.log
    fi
    
done
result1=$(displaydialog "The VPN is now connected. Please note, if this is your first time running this script, you must restart your computer for changes to take effect.")
printf "\r\n"