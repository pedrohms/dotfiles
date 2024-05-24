#!/usr/bin/env bash
xrandr --auto &> /dev/null
xrandr &> /dev/null && xrandr --auto
IS_HDMI=""
if [[ $PH_NVIDIA -eq "2" ]]; then
  IS_HDMI=$(xrandr | grep "HDMI-1-0 connected")
else
  IS_HDMI=$(xrandr | grep "HDMI-0 connected")
fi
if [[ $PH_NVIDIA -eq "2" ]]; then
  IS_DP_1=$(xrandr | grep "DP-1 connected")
else
  IS_DP_1=$(xrandr | grep "DP-1-1 connected")
fi

if [[ -n $IS_HDMI ]]; then
  if [[ $PH_NVIDIA -eq "2" ]]; then
    xrandr --output HDMI-1-0 --off
    xrandr --output HDMI-1-0 --mode 1920x1080 --dpi 96 --rate 60 --pos 1920x0 --output eDP-2 --primary --mode 1920x1200 --rate 120 --pos 0x0
  else
    xrandr --output HDMI-0 --off
    xrandr --output HDMI-0 --mode 1920x1080 --dpi 96 --rate 60 --pos 1920x0 --output eDP-2 --primary --mode 1920x1200 --rate 165 --pos 0x0
  fi
else 
  if [[ -n $IS_DP_1 ]]; then
    if [[ $PH_NVIDIA -eq "2" ]]; then
      # xrandr --output DP-1 --off
      xrandr --output DP-1 --mode 1920x1080 --dpi 96 --rate 60 --pos 1920x0 --output eDP-1 --primary --mode 1920x1080 --rate 120 --pos 0x0
    else
      # xrandr --output DP-1-1 --off
      xrandr --output DP-1-2 --mode 1920x1080 --dpi 96 --rate 60 --pos 1920x0 --output eDP-1-2 --primary --mode 1920x1080 --rate 120 --pos 0x0
    fi
  fi
fi
