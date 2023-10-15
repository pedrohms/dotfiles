#!/usr/bin/env bash

sleep 1
systemctl restart --user xdg-desktop-portal-hyprland.service &
systemctl restart --user xdg-desktop-portal-gnome.service &
systemctl restart --user xdg-desktop-portal-kde.service &
systemctl restart --user xdg-desktop-portal-lxqt.service &
systemctl restart --user xdg-desktop-portal-wlr.service &
systemctl restart --user xdg-desktop-portal.service &

# waybar &
# swaybg -m fill -i ~/.local/wall/0001.jpg # Set wallpaper
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & # for XDPH
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &# for XDPH
systemctl restart --user plasma-polkit-agent.service & # authentication dialogue for GUI apps
systemctl --user restart pipewire & # Restart pipewire to avoid bugs
dunst # start notification demon
wl-paste --type text --watch cliphist store & # clipboard store text data
wl-paste --type image --watch cliphist store & # clipboard store image data
