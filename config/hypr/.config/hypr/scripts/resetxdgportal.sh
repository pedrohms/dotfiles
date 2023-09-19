#!/usr/bin/env bash
sleep 1
systemctl restart --user xdg-desktop-portal-hyprland.service
systemctl restart --user xdg-desktop-portal-gnome.service
systemctl restart --user xdg-desktop-portal-kde.service
systemctl restart --user xdg-desktop-portal-lxqt.service
systemctl restart --user xdg-desktop-portal-wlr.service
systemctl restart --user xdg-desktop-portal.service
