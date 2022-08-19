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

ip_address=''

if [ -z "$1" ]; then
    ip_address=$(route -n | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | tr '\n' ',' | awk -F "," '{print $2}')
else
    ip_address_argument=$(echo $1 | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
    if [ "$1" == $ip_address_argument ]; then
	ip_address=$1
    else
	echo -e >&2 "${redColour}Must to be a ip address format${endColour}"; exit 1;
    fi
fi

echo -e "\n${yellowColour}[*] Host Discovery...${endColour}\n"

ip_network=$(echo $ip_address | awk -F "." '{print $1} {print $2} {print $3}' | tr '\n' '.')

for i in $(seq 1 255); do
    ip_targeted=$ip_network$i
    timeout 2 $SHELL -c "ping -c 1 $ip_targeted > /dev/null 2>&1" && echo -ne "\t${blueColour}[*] Host: $ip_targeted${endColour} - ${greenColour}ACTIVE${endColour} -> ${purpleColour}$(./osDiscovery.sh $ip_targeted)${endColour}\n" &
done; wait
