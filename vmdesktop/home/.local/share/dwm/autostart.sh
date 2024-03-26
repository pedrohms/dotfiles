#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
# setxkbmap -layout br -variant abnt2 &
setxkbmap -layout us -variant intl &
#start sxhkd to replace Qtile native key-bindings
flameshot &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
clipmenud &
ssh-add &
dunst &
xset r rate 210 17 &
xrandr --auto
xrandr --output Virtual-1 --mode 1920x1200
feh  --bg-fill $HOME/.local/wall/0001.jpg &
dwmblocks &
#picom --config $HOME/.config/picom/picom.conf &
