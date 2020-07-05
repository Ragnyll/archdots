#!/bin/bash -e

[ tmux ls | grep -qv attached ] && exec /usr/local/bin/st -e tmux attach || exec /usr/local/bin/st -e tmux
