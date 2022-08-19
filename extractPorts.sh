#!/bin/sh

# util colors
greenColour='\e[0;32m\033[1m'
endColour='\033[0m\e[0m'
redColour='\e[0;31m\033[1m'
blueColour='\e[0;34m\033[1m'
yellowColour='\e[0;33m\033[1m'
purpleColour='\e[0;35m\033[1m'
turquoiseColour='\e[0;36m\033[1m'
grayColour='\e[0;37m\033[1m'

# Util variables (Ip and opened ports)
ip=$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u)
output=$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS="/" | xargs | tr ' ' ',')

# Util output
echo -e "\n${yellowColour}[*] Extracting Information...${endColour}\n"

echo -e "\t${blueColour}[*] IP Address:${endColour} ${grayColour}$ip${endColour}"
echo -e "\t${blueColour}[*] Open Ports:${endColour} ${grayColour}$output${endColour}\n"

# Copying the port with 'xclip' command...
echo $output | tr -d '\n' | xclip -sel clip
echo -e "${yellowColour}[*] Open ports have been copied to the clipboard !${endColour}\n"

