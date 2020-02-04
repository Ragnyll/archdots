#!/bin/sh

if [ $(ps aux | grep nordvpnd | wc -l) -gt 1 ]; then
	nordvpn d
	sudo systemctl stop nordvpnd.service
else
	sudo systemctl start nordvpnd.service
	if [ $(echo $1 | grep Chicago | wc -l) -eq 1 ]; then
		nordvpn c Chicago
	elif [ $(echo $1 | grep Toronto | wc -l) -eq 1 ]; then
		nordvpn c Toronto
	elif [ $(echo $1 | grep London | wc -l) -eq 1 ]; then
		nordvpn c London
	elif [ $(echo $1 | grep disconnect | wc -l) -eq 1 ]; then
		nordpvn d
		sudo systemctl stop nordvpnd.service
	fi
fi
