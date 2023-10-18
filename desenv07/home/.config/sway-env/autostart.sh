#!/usr/bin/env bash

# Default env vars.
export XDG_CURRENT_DESKTOP=sway 
export XDG_SESSION_TYPE=wayland 
export XDG_SESSION_DESKTOP=sway 
export XDG_SCREENSHOTS_DIR=~/Pictures/Screenshots
export WLR_NO_HARDWARE_CURSORS=1 
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_ENABLE_WAYLAND=1 
export OZONE_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland 
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export GDK_BACKEND=wayland
# export X-KDE-DBUS-Restricted-Interfaces="org.kde.kwin.Screenshot,org.kde.KWin.ScreenShot2"

sleep 1
systemctl restart --user xdg-desktop-portal-hyprland.service &
systemctl restart --user xdg-desktop-portal-gnome.service &
systemctl restart --user xdg-desktop-portal-gtk.service &
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
