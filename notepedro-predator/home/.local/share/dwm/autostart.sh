#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
setxkbmap -layout br -variant abnt2 &
xrandr --auto
# xrandr --output HDMI-1-0 --off
#xrandr --output DP-1 --mode 1920x1080 --rate 60 --pos 1920x0 --output eDP-1 --primary --mode 1920x1080 --rate 120 --pos 0x0
#start sxhkd to replace Qtile native key-bindings
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
dwmblocks &
sh $HOME/.config/ph-autostart/verify_monitor.sh
