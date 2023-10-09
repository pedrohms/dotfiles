#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
exec $HOME/.config/ph-autostart/verify_monitor.sh
setxkbmap -layout br -variant abnt2 &
