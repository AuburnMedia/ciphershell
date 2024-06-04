#!/bin/bash

source ./functions.sh

printf "\r"
displaynotification "The VPN is now connecting. Do not turn off or restart your machine." "Connecting.."
progress-bar 5

while true; do
    for ((n = 1; n <= RANDOM / 10; n++)); do
        export n
        export rand01=$((RANDOM / 10))
        export rand02=$((RANDOM / 5000))
        if [ $n -eq 1 ]; then
            connection_system
        else
            proceed_connection
            echo $(date +"%T") "connecting network thread $n to VPN" >> log.log
            sleep 0.05
            echo $(date +"%T") "attempting to attach keychain $rand01 to network daemon" >> log.log
            if [ $rand01 -lt $rand02 ]; then
                echo $(date +"%T") "failed to connect thread $n with keychain identifier $rand01" >> log.log
            fi
        fi
    done

    if [ $n -lt 100 ]; then
        printf ""
    else
        break
    fi
done
result1=$(displaydialog "The VPN is now connected. Please note, if this is your first time running this script, you must restart your computer for changes to take effect.")
printf "\r\n"