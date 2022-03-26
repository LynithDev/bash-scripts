#!/bin/bash

# Popular shell paths
PATH_BASH=~/.bashrc
PATH_ZSH=~/.zshrc
PATH_FISH=~/.config/fish/config.fish

# Not popular shell path but for some reason this is the default in Alpine Linux
PATH_ASH=/etc/profile

read -p "Where is your shells config file? (Enter 'bash' 'zsh' 'ash' 'fish' for default locations) " ACTIVE_PATH

if [[ $ACTIVE_PATH == "bash" ]]
then
	ACTIVE_PATH=$PATH_BASH
elif [[ $ACTIVE_PATH == "zsh" ]]
then
	ACTIVE_PATH=$PATH_ZSH
elif [[ $ACTIVE_PATH == "fish" ]]
then
	ACTIVE_PATH=$PATH_FISH
elif [[ $ACTIVE_PATH == "ash" ]]
then
	ACTIVE_PATH=$PATH_ASH
fi

# curl it
rm -rf /opt/bash-scripts 
echo "Downloading .tar.gz"
cd /opt && { curl -sLO "https://github.com/LynithDev/bash-scripts/archive/master.tar.gz"; cd - > /dev/null; }
tar -xf /opt/master.tar.gz -C /opt
rm /opt/master.tar.gz
mv /opt/bash-scripts-master /opt/bash-scripts

# Set aliases
while IFS= read -r line; do
	if [[ ! ${line} == '' && ! -z $(grep "alias ${line}" $ACTIVE_PATH) ]]
	then
		echo "Duplicate"
	else
		echo "alias ${line}" >> $ACTIVE_PATH
	fi
done < /opt/bash-scripts/aliases.txt	

# Finish
echo "Install finished"
