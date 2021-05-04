#!/bin/bash

# Returns external monitor if one is connected.
# Otherwise returns the default monitor.

monitor="eDP-1"  # Default (built-in) monitor

if type "xrandr" > /dev/null; then
  for v in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$v" != "eDP-1" ]; then
      monitor="$v"
    fi
  done
fi
echo "$monitor"