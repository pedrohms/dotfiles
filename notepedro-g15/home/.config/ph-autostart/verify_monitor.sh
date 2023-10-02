#!/usr/bin/env bash
function verify_monitor {
  xrandr &> /dev/null && xrandr --auto
  IS_HDMI=$(xrandr | grep HDMI)

  if [[ -n $IS_HDMI ]] then
  IS_DISCONNECTED=$(xrandr | grep disconnected)
  if [[ -n $IS_DISCONNECTED ]] then
    return false
  else
    return true
  fi
  else 
    return false
  fi
}

xrandr --auto
xrandr --output HDMI-1-0 --off
if [[ verify_monitor ]] then
  xrandr --output HDMI-1-0 --mode 1920x1080 --rate 60 --pos 1920x0 --output eDP-1 --primary --mode 1920x1080 --rate 120 --pos 0x0
fi
