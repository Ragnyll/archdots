#!/bin/bash

# Install pacman dependencies dependencies
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

# enable services
systemctl --user enable headphones_hissing.service

# not needed for a base install
#================================
sudo pacman -Syu metasploit

# nord needs to be configured by hand after install
yay -S nordvpn-bin

# make nordvpn use wireguard
nordvpn set technology nordlynx

# Manual post install things
## XPS 13 - fix headphone hiss https://wiki.archlinux.org/index.php/Dell_XPS_13_(9360)#Continuous_hissing_sound_with_headphones
