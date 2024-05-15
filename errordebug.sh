#!/bin/sh

# Check if dialog is installed
if command -v dialog >/dev/null 2>&1; then
    dialog --yesno "There was an error running the script. Try again?" -1 -1
    sleep 1
    read "Continue?" contin
    printf "Working.. \n\n"
    sleep 2
else
    read "There was an error. Continue?" contin
fi