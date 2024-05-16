#!/bin/sh

consoleUser() {
	echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }'
}

displaynotification() { # $1: message $2: title
	message=${1:-"Message"}
	title=${2:-"Script Notification"}
	user=$(consoleUser)
    if [[ $user != "" ]]; then
        uid=$(id -u "$user")
		launchctl asuser $uid /usr/bin/osascript <<-EndOfScript
			display notification "$message" with title "$title"
		EndOfScript
	fi
}


displaynotification "An error occurred. The script will be stopped." "Error"