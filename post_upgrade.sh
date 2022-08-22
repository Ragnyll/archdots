#!/bin/bash

# There are a lot of shitty things arch does after you upgrade that make it hard to fix.
# These are general fixes after runing `pacman -Syu`

# rebuild python env
echo "rebuilding python env"
~/.dotfiles/python_installs.sh
echo "rebuilding python env"

# re build other installs
paru -R nvidia-settings && paru -S nvidia-settings
paru -R ranger-git && paru -S ranger-git
paru -R optimus-manager && paru -S optimus-manager
paru -R npm node-gyp nodejs semver && paru -S npm node-gyp nodejs semver

printf '========== Post Upgrade Step Complete! ==========
========== Inspect logs and restart ==========\n'
