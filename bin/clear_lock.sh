#!/bin/sh

IMAGE='/home/ragnyll/.dotfiles/images/lock_screen.png'
BLACK='#000000'
LIGHT_BROWN='c8c2ad'

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#ff00ffcc'  # default
T='#ee00eeee'  # text
W='#880000bb'  # wrong
V='#bb00bbbb'  # verifying

i3lock \
-n -i $IMAGE --tiling     \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--radius 225 \
--ring-width 15 \
\
--insidewrongcolor=$B \
--ringwrongcolor=$W   \
\
--indicator           \
--insidecolor=$B      \
--ringcolor=$BLACK    \
--linecolor=$B        \
--separatorcolor=$B   \
\
--verifcolor=$BLACK        \
--wrongcolor=$BLACK        \
--timecolor=$BLACK        \
--datecolor=$BLACK        \
--layoutcolor=$BLACK      \
--keyhlcolor=$LIGHT_BROWN       \
--bshlcolor=$W        \
\
--veriftext "Authenticating..." \
--wrongtext="ErRor!" \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y"

# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
