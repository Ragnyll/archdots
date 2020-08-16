#!/bin/sh

SATURATION=0.8

[ $1 ] && wal -i $1 --saturate $SATURATION -q

# $1 and $2 will be present during a background change or bspwm [re]start
. "${HOME}/.cache/wal/colors.sh"
bspc config normal_border_color "$color1" \
&& bspc config active_border_color "$color2" \
&& bspc config presel_feedback_color "$color1"
