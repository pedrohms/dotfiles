#!/usr/bin/env bash
# xrandr --auto
# xrandr --output HDMI-1-0 --off
# xrandr --output HDMI-1-0 --mode 1920x1080 --rate 60 --pos 1920x0 --output eDP-1 --primary --mode 1920x1080 --rate 120 --pos 0x0
# feh  --bg-fill $HOME/.local/wall/0001.jpg
setxkbmap -layout br -variant abnt2
sh $HOME/.config/ph-autostart/verify_monitor.sh
