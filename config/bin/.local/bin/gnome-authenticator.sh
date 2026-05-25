#!/usr/bin/env bash
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
flatpak run com.belmoussaoui.Authenticator
