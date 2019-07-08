#!/bin/bash

max_width=0
if type "xrandr" > /dev/null; then
  for w in $(xrandr --query | grep "*+" | cut -d" " -f4 | cut -d"x" -f1); do
    # Set env var for current main screen width
    if [ $((w + 0)) -gt $((max_width + 0)) ]; then
        max_width=$w
    fi
    # SCREEN_WIDTH=$m polybar --reload default -c ~/.config/polybar/config &
  done
fi
echo $(($max_width/8))x15