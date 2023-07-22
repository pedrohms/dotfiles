#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
lxsession &
nm-applet &
setxkbmap -layout br -variant abnt2
clipmenud &
ssh-add &
dunst &
feh  --bg-fill $HOME/.local/wall/0001.jpg &
picom --config $HOME/.config/picom/picom.conf --vsync &
xset r rate 210 40 &
