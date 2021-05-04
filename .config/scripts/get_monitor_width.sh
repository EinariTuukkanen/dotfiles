#!/bin/bash

max_width=0
if type "xrandr" > /dev/null; then
  for w in $(xrandr --query | grep "*+" | cut -d" " -f4 | cut -d"x" -f1); do
    if [ $((w + 0)) -gt $((max_width + 0)) ]; then
        max_width=$w
    fi
  done
fi
echo $max_width
# echo $(($max_width/8))x15