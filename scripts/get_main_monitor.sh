#!/bin/bash

active_monitor="eDP1"
if type "xrandr" > /dev/null; then
  for v in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # Set env var for current main screen name
    if [ "$v" != "eDP1" ]; then
      active_monitor="$v"
    fi
  done
fi
echo "$active_monitor"
