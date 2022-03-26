#!/bin/bash

# Popular shell paths
PATH_BASH=~/.bashrc
PATH_ZSH=~/.zshrc
PATH_FISH=~/.config/fish/config.fish

# Not popular shell path but for some reason this is the default in Alpine Linux
PATH_ASH=/etc/profile

if [[ $SHELL == "/bin/bash" ]]
then
	ACTIVE_PATH=$PATH_BASH
elif [[ $SHELL == "/bin/zsh" ]]
then
	ACTIVE_PATH=$PATH_ZSH
elif [[ $SHELL == "/bin/fish" ]]
then
	ACTIVE_PATH=$PATH_FISH
elif [[ $SHELL == "/bin/ash" ]]
then
	ACTIVE_PATH=$PATH_ASH
else
	echo "What shell are you even using lol bruh"
	exit 1
fi

# curl it
rm -rf /opt/bash-scripts 
echo "Downloading .tar.gz"
cd /opt && { curl -sLO "https://github.com/LynithDev/bash-scripts/archive/master.tar.gz"; cd -; }
tar -xf /opt/master.tar.gz -C /opt
rm /opt/master.tar.gz
mv /opt/bash-scripts-master /opt/bash-scripts

# Set aliases
while IFS= read -r line; do
	if [[ ! -z $(grep 'alias ${line}' $ACTIVE_PATH) ]]
	then
		echo "Duplicate"
	else
		echo "alias ${line}" >> $ACTIVE_PATH
	fi
done < /opt/bash-scripts/aliases.txt	

# Finish
echo "Install finished"
