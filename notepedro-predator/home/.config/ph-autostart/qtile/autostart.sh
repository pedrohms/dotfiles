#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

setxkbmap -layout br -variant abnt2
sh $HOME/.config/ph-autostart/verify_monitor.sh
xrandr --auto
sxhkd -c ~/.config/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
clipmenud &
ssh-add &
blueman-applet &
dunst &
feh  --bg-fill $HOME/.local/wall/0003.png &
picom --config $HOME/.config/picom/picom.conf &
xset r rate 210 40 &
flameshot &
setxkbmap -layout br -variant abnt2
