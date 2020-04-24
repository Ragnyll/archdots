#!/bin/bash

# Note this only support 1 display, if 2 are plugged in... time to reprogram

# This must be run on the nvidia graphics card. intel card is active i'll have to switch
if [ $(optimus-manager --status | grep 'Current GPU mode : intel' | wc -l )  -eq '1' ]; then
	echo "Must be on nvidia graphics to use multiple displays!" 1>&2
	exit 1
fi

# check which displays are connected, and go in preference order
LAPTOP_DISPLAY_NAME="eDP-1-1"
if [ $(xrandr -q | grep "DP-1 connected" | wc -l ) -eq  1 ]; then
	EXTERNAL_DISPLAY_NAME="DP-1"
elif [ $(xrandr -q | grep "HDMI-0 connected" | wc -l ) -eq  1 ]; then
	EXTERNAL_DISPLAY_NAME="HDMI-0"
elif [ $(xrandr -q | grep "HDMI-0 connected" | wc -l ) -eq  1 ]; then
	EXTERNAL_DISPLAY_NAME="DP-0"
fi
xrandr --output $EXTERNAL_DISPLAY_NAME --auto --right-of $LAPTOP_DISPLAY_NAME

# I will allways be using
if [ $(echo $1 | grep extend | wc -l) -eq 1 ]; then
	bspc monitor $EXTERNAL_DISPLAY_NAME -d $EXTERNAL_DISPLAY_NAME/1 $EXTERNAL_DISPLAY_NAME/2 $EXTERNAL_DISPLAY_NAME/3 $EXTERNAL_DISPLAY_NAME/4 $EXTERNAL_DISPLAY_NAME/5
	bspc monitor $LAPTOP_DISPLAY_NAME -d $LAPTOP_DISPLAY_NAME/6 $LAPTOP_DISPLAY_NAME/7 $LAPTOP_DISPLAY_NAME/8 $LAPTOP_DISPLAY_NAME/9 $EXTERNAL_DISPLAY_NAME/10
elif [ $(echo $1 | grep mirror | wc -l) -eq 1 ]; then
	echo "Kind of a hack. just remove the other display then try restart bspwm"
	bspc monitor $LAPTOP_DISPLAY_NAME -d $LAPTOP_DISPLAY_NAME/1 $LAPTOP_DISPLAY_NAME/2 $LAPTOP_DISPLAY_NAME/3 $LAPTOP_DISPLAY_NAME/4 $EXTERNAL_DISPLAY_NAME/5
	bspc wm -r
elif [ $(echo $1 | grep laptop | wc -l) -eq 1 ]; then
	echo "i made it 2"
elif [ $(echo $1 | grep external | wc -l) -eq 1 ]; then
	echo "i made it 3"
fi
