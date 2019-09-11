#!/bin/bash

# Insall pacman dependencies dependencies
sudo pacman -Syu wget lightdm lightdm-gtk-greeter bspwm sxhkd rxvt-unicode dmenu firefox unzip feh openssh zsh thunar pulseaudio compton rofi xclip kitty

#Install yay
git clone https://aur.archlinux.org/yay.get
cd yay
makepkg -si
cd .. && rm -rf yay/

# Install yay dependencies (Lots of manual intervention here. Be careful)
# First make sure yay is up to date
yay
yay -S polybar
yay -S urxvtconfig

# setup prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sf ~/.dotfiles/zpreztorc ~/.zpreztorc

# symlink nessecary confs
# DESTRUCTIVE
ln -s ~/.dotfiles/bin ~/bin
mkdir -p ~/.config/bspwm/
ln -sf ~/.dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
mkdir -p ~/.config/sxhkd/
ln -sf ~/.dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
mkdir -p ~/.config/polybar
ln -sf ~/.dotfiles/config/polybar/config ~/.config/polybar/config
ln -sf ~/.dotfiles/config/polybar/config ~/.config/polybar/launch.sh
ln -sf ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
