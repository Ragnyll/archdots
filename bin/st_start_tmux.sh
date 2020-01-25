#!/bin/sh -e

if tmux ls | grep -qv attached ; then
exec /usr/local/bin/st -e tmux attach
else
exec /usr/local/bin/st -e tmux
fi
