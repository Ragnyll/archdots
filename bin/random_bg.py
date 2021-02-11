#!/bin/python
# chooses and sets a random wal bg from bookmarked
from os import path
from random import choice
from subprocess import run
import sys
user_home = path.expanduser('~')
sys.path.append(path.join(user_home, 'bin'))
import xattr_utils

image_root_path = path.join(user_home, 'Pictures/wallpapers')
bg_path = choice(xattr_utils.get_files_with_metadata_tag(image_root_path, 'favorite'))
wal_setter_path = path.join(user_home, 'bin/wal_setter.sh')
run([wal_setter_path, bg_path])

# write current bg to ~/.config/wallpaper
with open(path.join(user_home, '.config/wallpaper'), 'w') as wallpaper_conf:
    wallpaper_conf.write(path.join(bg_path))
