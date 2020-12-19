#!/bin/python
# chooses and sets a random wal bg from bookmarked
from os import listdir, path
from random import choice
from subprocess import run

user_home = path.expanduser('~')
bookmarked_bg_dir = 'Pictures/wallpapers/bookmarked/'
bg_fname = choice(listdir(path.join(user_home, bookmarked_bg_dir)))
full_fpath = path.join(user_home, bookmarked_bg_dir, bg_fname)
wal_setter_path = path.join(user_home, 'bin/wal_setter.sh')
run([wal_setter_path, full_fpath])

# write current bg to ~/.config/wallpaper
with open(path.join(user_home, '.config/wallpaper'), 'w') as wallpaper_conf:
    wallpaper_conf.write(path.join(full_fpath))
