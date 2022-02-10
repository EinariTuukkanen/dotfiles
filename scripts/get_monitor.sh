#!/bin/bash

# Returns external monitor if one is connected.
# Otherwise returns the default monitor.

defaultMonitor=$(source ~/.config/scripts/get_default_monitor.sh)
monitor=$defaultMonitor  # Default (built-in) monitor

if type "xrandr" > /dev/null; then
  for v in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$v" != "$defaultMonitor" ]; then
      monitor="$v"
      break # For current setup, we need the first non-defaultMonitor screen
    fi
  done
fi
echo "$monitor"
