#!/bin/sh

# Utils colors
greenColour='\e[0;32m\033[1m'
endColour='\033[0m\e[0m'
redColour='\e[0;31m\033[1m'
blueColour='\e[0;34m\033[1m'
yellowColour='\e[0;33m\033[1m'
purpleColour='\e[0;35m\033[1m'
turquoiseColour='\e[0;36m\033[1m'
grayColour='\e[0;37m\033[1m'

# Global variables
ip_address=''
outuput_ttl=''

if [ -z "$1" ]; then
	echo -e >&2 "${redColour}[*] Must to enter a ip address as argument !${endColour}"; exit 1;
else
	ip_address_arg=$(echo $1 | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
	if [ "$1" == $ip_address_arg ]; then
		ip_address=$1
	else
		echo -e >&2 "${redColour}[*] Must to be a ip address format${endColour}"; exit 1;
	fi
fi

output_ttl=$(ping -c1 $ip_address | grep -oP "ttl=\d{1,3}" | awk -F "=" '{print $2}')

if [ $output_ttl -ge 0 ] && [ $output_ttl -le 64 ]; then
	echo "[Android/Linux/MacOS]"
elif [ $output_ttl -ge 65 ] && [ $output_ttl -le 128 ]; then
	echo "[Windows(7/10/11)]"
elif [ $output_ttl -ge 129 ] && [ $ouput_ttl -le 255 ]; then
	echo "[AIX/FreeBSD]"
else
	echo "[*] Check this list for more detail about the ttl ($output_ttl) : https://ostechnix.com/identify-operating-system-ttl-ping/"
fi
