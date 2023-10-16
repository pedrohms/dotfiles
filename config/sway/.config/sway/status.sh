#!/usr/bin/env bash
# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
volume=$($HOME/.local/bin/volume)

memory=$($HOME/.local/bin/memory)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M:%S")

# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
if [[ $USER -eq "framework" ]]; then
  echo $memory💻 "|" $volume🔉 "|" $linux_version🐧 "|" $date_formatted
else
  battery_status=$(cat /sys/class/power_supply/BAT0/status)
  echo $memory💻 "|" $volume🔉 "|" $linux_version🐧 "|" $battery_status 🔋 "|" $date_formatted
fi

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
