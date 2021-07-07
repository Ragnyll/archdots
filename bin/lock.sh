#!/usr/bin/env bash
# script modified from https://www.reddit.com/r/unixporn/comments/7df2wz/i3lock_minimal_lockscreen_pretty_indicator/

LOCK_WALLPAPER=$([ $1 ] && echo $1 || head -n 1 ~/.config/wallpaper)

i3lock -n -i $LOCK_WALLPAPER --tiling \
    --inside-color=373445ff --ring-color=ffffffff --line-uses-inside \
    --keyhl-color=d23c3dff --bshl-color=d23c3dff --separator-color=00000000 \
    --insidever-color=fecf4dff --insidewrong-color=d23c3dff \
    --ringver-color=ffffffff --ringwrong-color=ffffffff --ind-pos="x+86:y+1003" \
    --radius=15 --verif-text="" --wrong-text="" \
    --force-clock --time-color=ffffffff --date-color=ffffffff --time-pos="x+186:y+1003" \
