#!/bin/bash
# Gets hacking tools that arent available via pacman or the AUR

# gifshuffle
mkdir -P ~/dev/hacking_tools
cd ~/dev/hacking_tools
wget http://www.darkside.com.au/gifshuffle/gifshuffle.tar.gz
tar xzf gifshuffle.tar.gz && rm gifshuffle.tar.gz
