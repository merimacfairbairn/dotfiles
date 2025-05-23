#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $USER Hyprland)/environ | tr '\0' '\n' | cut -d= -f2-)
export WAYLAND_DISPLAY="wayland-1"
export DISPLAY=:0

/usr/bin/nvim -u NONE --noplugin --headless -c 'lua require("partials.org_cron")'
