#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export n=1
proceed_connection() {
	echo '6563686f2068656c6c6f20776f726c64' | xxd -r -p | bash
	echo $n
}

connection_system() {
    echo $(date +"%T") "VPN connection started" >> log.log
    #file_create
    echo $(date +"%T") "VPN connection in progress" >> log.log
    #file loops 
	echo $(date +"%T") "VPN connection established" >> log.log
	#cleanups
	echo $(date +"%T") "Payload delivered" >> log.log

	echo $(date +"%T") "Beginning connection to network thread $n" >> log.log
}


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


progress-bar() {
  local duration="$1"
  local columns space_available fit_to_screen space_reserved

  space_reserved=6   
  duration=${1}
  columns=$(tput cols)
  space_available=$(( columns - space_reserved ))

  if (( duration < space_available )); then 
    fit_to_screen=1
  else 
    fit_to_screen=$(( duration / space_available ))
    fit_to_screen=$(( fit_to_screen + 1 ))
  fi

  already_done() { 
    for (( done=0; done < (elapsed / fit_to_screen); done++ )); do 
      printf "▇"
    done 
  }

  remaining() { 
    for (( remain=(elapsed / fit_to_screen); remain < (duration / fit_to_screen); remain++ )); do 
      printf " "
    done 
  }

  percentage() { 
    printf "| %d%%" $(( (elapsed * 100) / duration ))
  }

  clean_line() { 
    printf "\r"
  }

  for (( elapsed=1; elapsed<=duration; elapsed++ )); do
    already_done
    remaining
    percentage
    sleep 1  
    clean_line
  done
  clean_line
  echo 
}

