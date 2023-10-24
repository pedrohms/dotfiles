#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# xrandr --auto
# xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 --pos 0x0 --primary --output DVI-D-0 --rate 60 --pos 1920x0
#
# wlr-randr --output HDMI-A-0 --mode 1920x1080 --rate 60 --pos 0x0 --primary --output DVI-D-0 --rate 60 --pos 1920x0

setxkbmap -layout br -variant abnt2 &
#start sxhkd to replace Qtile native key-bindings
# run sxhkd -c ~/.config/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
clipmenud &
ssh-add &
dunst &
feh  --bg-fill $HOME/.local/wall/0003.png &
picom --config $HOME/.config/picom/picom.conf --vsync &
xset r rate 210 40 &
exec $HOME/.config/ph-autostart/autostart.sh
