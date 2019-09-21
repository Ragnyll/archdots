#!/usr/bin/env bash
# This script is for testing rofi themes.
# It points directly at dotfiles instead of handling the symlink.
# Running 
# ls | entr -r $HOME/.dotfiles/config/rofi/run_rofi.sh 
# from the shell will run rofi evertime the config is regnerated

options="one
two
three"
theme=${1:-$HOME/.dotfiles/config/rofi/sidebar.rasi}
selection=$(echo -e "${options}" | rofi -dmenu -config $theme)
case "${selection}" in
  "one")
    notify-send "run_rofi.sh" "one";;
  "two")
    notify-send "run_rofi.sh" "two";;
  "three")
    notify-send "run_rofi.sh" "three";;
esac
