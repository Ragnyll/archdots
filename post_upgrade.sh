#!/bin/bash

# There are a lot of shitty things arch does after you upgrade that make it hard to fix.
# These are general fixes after runing `pacman -Syu`

# rebuild python env
~/.dotfiles/python_installs.sh

# re build other installs
yay -R nvidia-settings && yay -S nvidia-settings
yay -R ranger-git && yay -S ranger-git
yay -R optimus-manager && yay -S optimus-manager
yay -R npm node-gyp nodejs semver && yay -S npm node-gyp nodejs semver

printf '========== Post Upgrade Step Complete! ==========
========== Inspect logs and restart ==========\n'
