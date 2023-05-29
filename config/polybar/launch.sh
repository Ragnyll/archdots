#!/bin/bash
killall polybar
$(polybar --list-monitors | grep HDMI-1-0 && polybar --reload cristina-bar-connected || polybar --reload cristina-bar-laptop) &
