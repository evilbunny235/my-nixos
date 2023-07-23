#!/bin/sh

grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')" - | wl-copy -t image/png
