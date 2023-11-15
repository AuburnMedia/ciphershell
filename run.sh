#!/bin/bash


process_connection() {
    if [ "$connected" -eq 1 ]; then
        verified=1
    elif [ "$connected" -eq 182 ] || [ "$connected" -eq 255 ] || [ "$connected" -eq 166 ]; then
        ./errordebug.sh
    elif [ "$connected" -eq 0 ] || [ "$connected" -eq 2 ]; then
        printf "\nNot connected. Please select 'Connect' or verify that all other VPNs are disabled."
    fi
}





echo "1.) Install"
echo "2.) Connect"
echo "3.) Verify connection"
echo "4.) Settings"
echo "5.) Uninstall"
echo "6.) Update"
echo "7.) Quit"

sleep 1
printf "\n\n"
printf "Enter your choice (1-7):" 


case $choice in
    1)
        ./installer.sh
        ;;
    2)
        ./connect.sh
        ;;
    3)
        process_connection
        ;;
    4)
        # Add your settings logic here
        ;;
    5)
        # Add your uninstall logic here
        ;;
    6)
        # Add your update logic here
        ;;
    7)
        exit 0
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 7."
        ;;
esac