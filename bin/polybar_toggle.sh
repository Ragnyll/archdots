#!/bin/bash

if [ $(ps aux | grep "polybar --reload ragbar" | wc -l) -ge 2 ]; then
	pkill -f "polybar --reload ragbar"
else
    ~/.config/polybar/launch.sh &
fi
