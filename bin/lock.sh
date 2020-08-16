#!/usr/bin/env bash
# script modified from https://www.reddit.com/r/unixporn/comments/7df2wz/i3lock_minimal_lockscreen_pretty_indicator/

LOCK_WALLPAPER=$([ $1 ] && echo $1 || head -n 1 ~/.config/wallpaper)

i3lock -n -i $LOCK_WALLPAPER --tiling \
    --insidecolor=373445ff --ringcolor=ffffffff --line-uses-inside \
    --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
    --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+86:y+1003" \
    --radius=15 --veriftext="" --wrongtext="" \
    --force-clock --timecolor=ffffffff --datecolor=ffffffff --timepos="x+186:y+1003" \
