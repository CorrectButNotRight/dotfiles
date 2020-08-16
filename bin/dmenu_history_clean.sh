#!/bin/sh

file=/home/andrew/.cache/dmenu_history
while read -r line ; do
	if ! $(command -v "${line#*	}" >/dev/null 2>&1) ; then
		sed -i "/${line}/d" $file
	fi
done < $file
