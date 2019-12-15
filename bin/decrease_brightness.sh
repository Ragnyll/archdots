#!/bin/sh

# needs to handle multiple displays and only decrease laptop brightness
LAPTOP_DISPLAY_NAME="eDP-1-1"

# Get current brightness
BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d " "`
BRIGHTNESS=$(echo "$BRIGHTNESS-.1" | bc)

xrandr --output $LAPTOP_DISPLAY_NAME --brightness $BRIGHTNESS
