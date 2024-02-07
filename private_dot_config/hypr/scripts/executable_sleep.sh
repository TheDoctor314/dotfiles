#!/usr/bin/env bash

IMG="$HOME/Pictures/Wallpapers/triangle.png"

swayidle -w timeout 300 "swaylock -f -i $IMG" \
            timeout 600 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            timeout 900 'systemctl suspend' \
            before-sleep "swaylock -f -i $IMG" &
