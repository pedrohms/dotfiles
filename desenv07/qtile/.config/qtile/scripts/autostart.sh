#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
setxkbmap -layout us -variant intl &
#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
clipmenud &
ssh-add &
dunst &
feh  --bg-fill $HOME/.local/wall/0001.jpg &
picom --config $HOME/.config/picom/picom.conf --vsync &
xset r rate 210 40 &
