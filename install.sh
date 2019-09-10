#!/bin/bash

sudo pacman -Syu wget lightdm lightdm-gtk-greeter bspwm sxhkd rxvt-unicode dmenu firefox unzip feh
mkdir -p ~/.config/bspwm/
ln -sf ~/.dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
mkdir -p ~/.config/sxhkd/
ln -sf ~/.dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
