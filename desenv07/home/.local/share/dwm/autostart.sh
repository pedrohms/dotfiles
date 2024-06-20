#!/usr/bin/env bash

PH_AUTOSTART="$HOME/.config/ph-autostart/autostart.sh"
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
setxkbmap -layout br -variant abnt2 &
#start sxhkd to replace Qtile native key-bindings
flameshot &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc &
# lxsession &
nm-applet &
clipmenud &
ssh-add &
dunst &
xset r rate 240 40 &
# xrandr --auto
# xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 --pos 0x0 --primary --output DVI-D-0 --rate 60 --pos 1920x0
feh  --bg-fill $HOME/.local/wall/fedora.jpg &
dwmblocks &
picom --config $HOME/.config/picom/picom.conf --vsync &
sh $HOME/.config/ph-autostart/verify_monitor.sh
if [[ -f $PH_AUTOSTART ]]; then
  sh $PH_AUTOSTART
fi
