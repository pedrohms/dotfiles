#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
# exec $HOME/.config/ph-autostart/verify_monitor.sh
setxkbmap -layout br -variant abnt2 &
xrandr --auto
xrandr --output Virtual-1 --mode 1920x1200
