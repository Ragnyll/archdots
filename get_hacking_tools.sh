#!/bin/bash
# Gets hacking tools that arent available via pacman or the AUR

mkdir -P ~/Applications
cd ~/dev/Applications

# gifshuffle - for stego with gifs
wget http://www.darkside.com.au/gifshuffle/gifshuffle.tar.gz
tar xzf gifshuffle.tar.gz && rm gifshuffle.tar.gz
sudo ln -S ~/Applications/gifshuffle/gifshuffle /usr/local/bin/gifshuffle

# OWASP ZAP
wget https://github.com/zaproxy/zaproxy/releases/download/v2.9.0/ZAP_2.9.0_Linux.tar.gz
tar xzf ZAP_2.9.0_Linux.tar.gz && rm ZAP_2.9.0_Linux.tar.gz
sudo ln -S ~/Applications/ZAP_2.9.0/zap.sh zap.sh
