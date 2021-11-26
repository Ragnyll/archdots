#!/bin/bash

# INSTALL NOTES:
# SD card reader is disabled by bios.
# sudo must be installed before most of this can run

# call all scripts relative to this directory.
cd ~/.dotfiles

# Install pacman dependencies
# You probably have git if you pulled this repo, but install it to be safe
# notes:
# 	  uninstall lxappeareance after setting arc-dark-theme for nautilis
sudo pacman -Syu git lxappeareance

# prefer install from yay to avoid having to install as root
git clone https://aur.archlinux.org/yay.get
cd yay
makepkg -si
cd .. && rm -rf yay/
# if an install fails try installing things in install.txt one at a time
yay -S $(awk '{print $1}' install.txt)

# install pip
~/.dotfiles/python_installs.sh

mkdir ~/dev

# symlink nessecary confs
# DESTRUCTIVE
ln -sf ~/.dotfiles/zpreztorc ~/.zpreztorc
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zprofile ~/.zprofile
ln -sf ~/.dotfiles/zfunc ~/.zfunc
ln -sf ~/.dotfiles/aliases ~/.aliases
ln -sf ~/.dotfiles/bin ~/bin
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/gitignore_global ~/.gitignore_global
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/config ~/.config
ln -sf ~/.dotfiles/surf ~/.surf


# install mutt
git clone git@gitlab.com:Ragnyll/my_mutt.git && cd my_mutt && install.sh && cd ..

# enable services
systemctl --user enable --now headphones_hissing.service
systemctl --user enable --now powertop.service
systemctl --user enable --now nordvpnd

# make nordvpn use wireguard
nordvpn set technology nordlynx
nordvpn cybernsec true

# install my fork of st
git clone https://gitlab.com/Ragnyll/st.git
cd st && sudo make && sudo make install

# install my fork of dmenu
git clone https://gitlab.com/Ragnyll/rag-dmenu.git
cd rag-dmenu && sudo make && sudo make install

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -L get.rvm.io > rvm-install
bash < ./rvm-install

# change shell to zsh (might affect later calls)
# (manual intervention say no to most thigns since most dotfile symlinks have happened)
chsh -s zsh

# setup prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  # this will fail for zfiles which have already been created which is fine
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Install fzf manually to get zsh keybinds (Manual intervention)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
