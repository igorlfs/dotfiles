#!/bin/sh
# Start a new recording if a selection is given.
#
# It may also be interesting to select a window instead
# This can be achieved by using swaymsg and jq (NEEDS TO BE INSTALLED)
# window=swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp

file="$HOME/recording-$(date +'%d-%m-%y_%H-%M-%S').mp4"

selection=$(slurp)

test -z "$selection" && echo "Empty selection" && exit 1

# See https://github.com/ammen99/wf-recorder/issues/152#issuecomment-1166593274 for why we need to use "-t"
wf-recorder -t -g "$selection" -f "$file" "$@"
