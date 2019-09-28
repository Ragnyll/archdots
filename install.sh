#!/bin/bash

# INSTALL NOTES:
# SD card reader is disabled by bios.

# Install pacman dependencies dependencies
# notes:
#     entr is for troubleshooting rofi
# 	  uninstall lxappeareance after setting arc-dark-theme for nautilis
sudo pacman -Syu \
	wget \
	lightdm \
	lightdm-gtk-greeter\
	bspwm \
	sxhkd \
	rxvt-unicode \
	dmenu \
	firefox \
	unzip \
	feh \
	openssh \
	zsh \
	thunar \
	pulseaudio \
	compton \
	rofi \
	xclip \
	kitty \
	neovim \
	powerline-fonts \
	git \
	otf-fira-code \
	gimp \
	light-locker \
	wireguard-tools \
	wireguard-arch \
	vlc \
	alsa-utils \
	bluez \
	bluez-utils \
	ranger \
	entr \
	lxappearance-gtk3 \
	arc-gtk-theme \
	w3m


# change shell to zsh (might affect later calls)
# (manual intervention)
chsh -s zsh

# Download important images
# background
# neofetch conf image

#Install yay
git clone https://aur.archlinux.org/yay.get
cd yay
makepkg -si
cd .. && rm -rf yay/

# manual installs
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install yay dependencies (Lots of manual intervention here. Be careful)
# First make sure yay is up to date
yay
yay -S polybar ttf-font-awesome lightdm-mini-greeter i3lock-fancy

# Install fzf manually to get zsh keybinds (Manual intervention)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# setup prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sf ~/.dotfiles/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/zshrc ~/.zshrc

# symlink nessecary confs
# DESTRUCTIVE
ln -s ~/.dotfiles/bin ~/bin
mkdir -p ~/.config/bspwm/
ln -sf ~/.dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
mkdir -p ~/.config/sxhkd/
ln -sf ~/.dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
mkdir -p ~/.config/polybar/
ln -sf ~/.dotfiles/config/polybar/config ~/.config/polybar/config
ln -sf ~/.dotfiles/config/polybar/config ~/.config/polybar/launch.sh
ln -sf ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/compton/
ln -s ~/.dotfiles/config/compton/compton.conf ~/.config/compton/compton.conf  
ln -s ~/.dotfiles/bin/increase_brightness.sh ~/bin/increase_brightness.sh
ln -s ~/.dotfiles/bin/decrease_brightness.sh ~/bin/decrease_brightness.sh
mkdir -p ~/.config/systemd/user/
ln -sf ~/.dotfiles/config/systemd/user/headphones_hissing.service ~/.config/systemd/user/headphones_hissing.service
mkdir -p ~/.config/neofetch/
ln -sf ~/.dotfiles/config/neofetch/config.conf ~/.config/neofetch/config.conf
mkdir -p ~/.config/rofi/themes
ln -sf ~/.dotfiles/config/rofi/themes/dracula_sidebar.rasi ~/.config/rofi/themes/dracula_sidebar.rasi
ln -sf ~/.dotfiles/config/rofi/config ~/.config/rofi/config
ln -s ~/.dotfiles/bin/lock.sh ~/bin/lock.sh

# enable services
systemctl --user enable headphones_hissing.service

# not needed for a base install
# ================================
sudo pacman -Syu metasploit \
	libreoffice-still # note: libre office does not come with a grammar checker by default and i did not install one

# nord needs to be configured by hand after install
yay -S nordvpn-bin

# make nordvpn use wireguard
nordvpn set technology nordlynx
