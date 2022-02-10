#!/bin/bash

# Returns external monitor if one is connected.
# Otherwise returns the default monitor.

defaultMonitor=$(source ~/.config/scripts/get_default_monitor.sh)

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
primaryMonitor=$(source ${__dir}/get_monitor.sh)
monitor=""

if type "xrandr" > /dev/null; then
  for v in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$v" != "$defaultMonitor" ] && [ "$v" != "$primaryMonitor" ]; then
      monitor="$v"
      break # Use the first match
    fi
  done
fi

echo "$monitor"
