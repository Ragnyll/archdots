#!/bin/bash
# toggles conky being on or off

if [ $(ps aux | grep conky | wc -l) -ge 4 ]; then
	pkill -f conky
else
	conky -d
fi

