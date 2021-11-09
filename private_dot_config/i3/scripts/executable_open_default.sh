#!/usr/bin/env bash

# requires `jq`

default_apps=("" "firefox" "i3-sensible-terminal" "code" "nautilus")

index=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')

${default_apps[$index]} &
