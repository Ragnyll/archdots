#!/bin/sh

if [ $(echo $1 | grep intel | wc -l) -eq 1 ]; then
	sudo optimus-manager --switch intel --no-confirm
elif [ $(grep $1 | grep nvidia | wc -l) -eq 1 ]; then
	sudo optimus-manager --switch nvidia --no-confirm
fi

