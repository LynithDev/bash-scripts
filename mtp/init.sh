#!/bin/bash

if [[ "$1" == "u" ]]
then
	printf "Unmounting /mnt/ext"
	fusermount -u /mnt/ext && printf " - Ok\n"
else
	printf "Starting fuse module"
	modprobe fuse && printf " - Ok\n"

	printf "Mounting to /mnt/ext"
	simple-mtpfs -o allow_other /mnt/ext && printf ' - Ok\n'
fi
