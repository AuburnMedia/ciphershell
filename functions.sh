#!/bin/bash

# credit: ab, scriptingosx.com
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

consoleUser() {
	echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }'
}

displaydialog() { # $1: message
	message=${1:-"Message"}
	user=$(consoleUser)
    if [[ $user != "" ]]; then
        uid=$(id -u "$user")
		launchctl asuser $uid /usr/bin/osascript <<-EndOfScript
			button returned of ¬
			    (display dialog "$message" ¬
				buttons {"OK"} ¬
				default button "OK")
		EndOfScript
	fi
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


displayfortext() { # $1: message $2: default text
	message=${1:-"Message"}
	defaultvalue=${2:-"default value"}
	user=$(consoleUser)
    if [[ $user != "" ]]; then
        uid=$(id -u "$user")
	
	    launchctl asuser $uid /usr/bin/osascript <<-EndOfScript
			text returned of ¬
				(display dialog "$message" ¬
					default answer "$defaultvalue" ¬
					buttons {"OK"} ¬
					default button "OK")
			EndOfScript
	else
	    exit 1
	fi
}

# end credit
# credit edouard-lopez/progress-bar.sh
progress-bar() {
  local duration=${1}


    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}