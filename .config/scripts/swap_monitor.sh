#!/bin/bash

# Switches monitor to external if param 'ext' is given.
# Otherwise switches back to internal eDP-1.

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FROM=$(source ${__dir}/get_monitor.sh)
TO="eDP-1"

# If param 'ext' is given, swap the order around and target external monitor
if [ "$1" == "ext" ]; then
  FROM="eDP-1"
  TO=$(source ${__dir}/get_monitor.sh)
fi

# Activate monitors
# NOTE: commands are separated to support $FROM == $TO
xrandr --output $FROM --off
xrandr --output $TO --auto

# Swap desktop 1 with the placeholder desktop
# NOTE: we cannot swap focused desktop, so make sure we are not on desktop 1 when swapping
CURRENT_DESKTOP=$(bspc query -D -d focused)
bspc desktop 2 -f
bspc desktop 1 -s Desktop

# Move rest of the desktops (2-9, 0)
for ((i=2;i<=9;i++)); do
  bspc desktop $i --to-monitor $TO
done
bspc desktop 0 --to-monitor $TO

# Remove all but the target monitor
for monitor in $(bspc query -M --names); do
  if [ "$TO" != "$monitor" ]; then
    bspc monitor $monitor --remove
  fi
done

# Focus back to correct desktop
bspc desktop $CURRENT_DESKTOP -f

# Finally refresh everything
bspc wm -r

# TODO: figure out why kb layout resets and fix by using proper init file instead of doing this here
setxkbmap -layout fi -option "nbsp:none"
