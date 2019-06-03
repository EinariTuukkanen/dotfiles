#!/bin/bash

# counter=0
# i3-msg -t get_workspaces | tr ',' '\n' | sed -nr 's/"name":"([^"]+)"/\1/p' | while read -r name; do
#   printf 'ws-icon-%i = "%s;<insert-icon-here>"\n' $((counter++)) $name
# done

# Terminate any currently running instances
killall -q polybar

# Pause while killall completes
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # Set env var for automatically adding polybar to all monitors
    MONITOR=$m polybar --reload default -c ~/.config/polybar/config &
  done
else
  polybar --reload default -c ~/.config/polybar/config &
fi

echo "Polybar launched!"
