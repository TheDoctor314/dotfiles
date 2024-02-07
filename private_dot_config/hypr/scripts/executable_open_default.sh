#!/usr/bin/env bash

# requires `jq`

default_apps=("" "firefox" "alacritty" "code" "thunar")

index=$(hyprctl activeworkspace -j | jq '.id')

hyprctl dispatch exec ${default_apps[$index]}
