#!/bin/bash

WALLPAPER="$(find ~/Pictures/Wallpapers -type f | shuf -n 1)"

swaybg -i $WALLPAPER -m stretch
