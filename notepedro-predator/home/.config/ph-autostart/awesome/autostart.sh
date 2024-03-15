#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
# exec $HOME/.config/ph-autostart/verify_monitor.sh
setxkbmap -layout br -variant abnt2 &
xrandr --output eDP-1-2 --primary --mode 1920x1200 --rate 165 --pos 0x0 --output HDMI-0 --mode 1920x1080 --rate 60 --pos 1920x0
