#!/bin/bash

# Returns default monitor by using the prefix.

defaultPrefix="eDP"
monitor=$defaultPrefix

if type "xrandr" > /dev/null; then
  for v in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $v == $defaultPrefix* ]]; then
      monitor="$v"
      break # Found default monitor
    fi
  done
fi
echo "$monitor"
