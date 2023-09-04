#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
xrandr --auto
xrandr --output HDMI-1-0 --off
xrandr --output HDMI-1-0 --mode 1920x1080 --rate 60 --pos 1920x0 --output eDP-1 --primary --mode 1920x1080 --rate 120 --pos 0x0
setxkbmap -layout br -variant abnt2 &
#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
clipmenud &
ssh-add &
dunst &
feh  --bg-fill $HOME/.local/wall/0001.jpg &
nvidia-offload picom --config $HOME/.config/picom/picom.conf --vsync &
xset r rate 210 40 &
flameshot &
