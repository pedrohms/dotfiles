#!/usr/bin/env bash
xrandr --auto &> /dev/null
xrandr &> /dev/null && xrandr --auto
IS_HDMI=$(xrandr | grep "HDMI-A-0 connected")
IS_DVI_0=$(xrandr | grep "DVI-D-0 connected")

if [[ -n $IS_HDMI ]]; then
    xrandr --output DVI-D-0 --off
    xrandr --output HDMI-A-0 --mode 1920x1080 --dpi 96 --rate 60 --pos 1920x0 --output DVI-D-0 --primary --mode 1920x1080 --rate 60 --pos 0x0
fi
