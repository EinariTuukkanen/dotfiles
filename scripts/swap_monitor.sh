#!/bin/bash

# Switches monitor to external if param 'ext' is given.
# Otherwise switches back to internal monitor.
defaultMonitor=$(source ~/.config/scripts/get_default_monitor.sh)

secondaryDesktopName="Secondary"

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
primaryMonitor=$(source ${__dir}/get_monitor.sh)
secondaryMonitor=$(source ${__dir}/get_secondary_monitor.sh)

stripName () {
  local name=$(echo $1 | tr . _)
  echo "$name"
}

FROM=$primaryMonitor
TO="$defaultMonitor"

# If param 'ext' is given, swap the order around and target external monitor
if [ "$1" == "ext" ]; then
  FROM="$defaultMonitor"
  TO="$primaryMonitor"
fi

# Validated versions for bspc usage
bspDefaultMonitor=$(stripName $defaultMonitor)
bspPrimaryMonitor=$(stripName $primaryMonitor)
bspSecondaryMonitor=$(stripName $secondaryMonitor)
bspTO=$(stripName $TO)
bspFROM=$(stripName $FROM)

# Activate monitors
# NOTE: commands are separated to support $FROM == $TO
xrandr --output $FROM --off
echo "--> Turning off monitor $FROM"

xrandr --output $TO --primary --auto
echo "--> Turning on primary monitor $TO"

# Turn on secondary monitor
if [ "$secondaryMonitor" != "" ] && [ "$TO" != "$defaultMonitor" ]; then
  echo "--> Turning on secondary monitor $secondaryMonitor"
  xrandr --output $secondaryMonitor --auto --right-of $TO
  bspc desktop Desktop -n $secondaryDesktopName
fi

# Strip invalid characters from monitor names
echo "--> Validating monitor names"
for monitor in $(bspc query -M); do
  oldName=$(bspc query -M -m $monitor --names)
  newName=$(stripName $oldName)
  echo "Renaming $oldName to $newName"
  bspc monitor $monitor --rename $newName
done

if [ "$secondaryMonitor" != "" ] && [ "$TO" == "$defaultMonitor" ]; then
  echo "--> Turning off secondary monitor $secondaryMonitor"
  xrandr --output $secondaryMonitor --off
  for node in $(bspc query -N -m $bspSecondaryMonitor); do
    echo "--> Moving secondary node $node to 9"
    bspc node $node --to-desktop 9
  done
  bspc monitor $bspSecondaryMonitor --remove
fi

# Swap desktop 1 with the placeholder desktop
# NOTE: we cannot swap focused desktop, so make sure we are not on desktop 1 when swapping
CURRENT_DESKTOP=$(bspc query -D -d focused)

bspc desktop 2 -f
bspc desktop 1 -s Desktop # bspwm creates default "Desktop" on new monitor, so swap it with 1

# Move rest of the desktops (2-9, 0)
for ((i=2;i<=9;i++)); do
  bspc desktop $i --to-monitor $bspTO
done
bspc desktop 0 --to-monitor $bspTO

# Remove all but the target monitor
for monitor in $(bspc query -M --names); do
  echo "At this point exists monitor: $monitor"
  if [ "$monitor" != "$bspTO" ] && [ "$monitor" != "$bspSecondaryMonitor" ]; then
    echo "--> Removing monitor $monitor"
    # for node in $(bspc query -N -m $monitor); do
    #   echo "--> Moving node $node to 9"
    #   bspc node $node --to-desktop 9
    # done
    bspc monitor $monitor --remove
  fi
done

# Focus back to correct desktop
bspc desktop $CURRENT_DESKTOP -f
echo "--> Focusing desktop $CURRENT_DESKTOP"

if [ "$secondaryMonitor" != "" ] && [ "$TO" != "$defaultMonitor" ]; then
  echo "--> Reset secondary monitor desktops"
  bspc monitor $bspSecondaryMonitor -d $secondaryDesktopName
fi

# Finally refresh everything
echo "--> Reload wm"
currentPrimary=$(bspc query -M primary --names)
echo "Current primary monitor $currentPrimary"
bspc wm -r

# if [ "$secondaryMonitor" != "" ]; then
#   bspc monitor $secondaryMonitor -d $secondaryDesktopName
# fi

# TODO: figure out why kb layout resets and fix by using proper init file instead of doing this here
setxkbmap -layout fi -option "nbsp:none"
