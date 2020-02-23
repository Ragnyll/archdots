#!/bin/bash

# Cycle the keyboard backlight brightness by increments of 1 (decimal not allowed). If keyboard brightness is 2 roll back to 0

if [ $(sudo cat /sys/class/leds/tpacpi::kbd_backlight/brightness | grep "0" | wc -l) -eq 1 ]; then
	echo 1 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness
elif [ $(sudo cat /sys/class/leds/tpacpi::kbd_backlight/brightness | grep "1" | wc -l) -eq 1 ]; then
	echo 2 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness
elif [ $(sudo cat /sys/class/leds/tpacpi::kbd_backlight/brightness | grep "2" | wc -l) -eq 1 ]; then
	echo 0 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness
fi
