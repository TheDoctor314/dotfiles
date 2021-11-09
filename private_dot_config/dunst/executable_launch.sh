#!/usr/bin/env bash

source "$HOME/.cache/wal/colors.sh"

pkill dunst
dunst \
    -frame-width 0 \
    -lb "${color0}" \
    -nb "${color0}" \
    -cb "${color0}" \
    -lf "${color7}" \
    -bf "${color7}" \
    -cf "${color7}" \
    -nf "${color7}" &

