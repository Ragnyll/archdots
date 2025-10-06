#!/usr/bin/env bash

if [ x"$@" = x"quit" ]
then
    exit 0
fi
echo -en "app\0icon\x1ffolder-music\n"
echo "quit"
