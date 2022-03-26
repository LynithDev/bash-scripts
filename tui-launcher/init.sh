#!/bin/bash

# Script
printf "\033c\n"

WT="\u001b[37m"
RD="\u001b[31m"
RT="\u001b[0m"
YW="\u001b[33m"
GN="\u001b[32m"

apps=()

while IFS= read -r line; do
	for entry in "/usr/bin/"*; do
		if [[ $entry == "/usr/bin/$line" ]]
		then
			apps+=("${line}")
		fi
	done
done < ./apps.txt


ask() {
	while true; do
		printf "  Which app would you like to choose? (Enter number)\n"
		for i in ${!apps[@]}; do
			printf "\n   ${GN}${i}${RT} - ${YW}${apps[$i]}${RT}"
		done
		printf "\n\n  ${YW}ID${RT}: (Default 0) "
		read appID;
		if [ "${#apps[@]}" -gt "$appID" ];then
			printf "\033c\n  ${GN}Selected${RT}: ${YW}${apps[$appID]}${RT}"
			break
		else
			printf "\033c\n  ${RD}${appID} is not a valid app id${RT}\n\n"
		fi
	done
}
ask
while true; do
	printf "\n  Are you sure you want to launch ${YW}${apps[$appID]}${RT}? [${GN}y${RT}/${RD}n${RT}] ";read yn
	case $yn in
		[Yy]* ) ${apps[$appID]}; break;;
		[Nn]* ) break;;
		* ) printf "\n  Please answer with a ${GN}Y${RT} (yes) or ${RD}N${RT} (no)";;
	esac
done
echo
