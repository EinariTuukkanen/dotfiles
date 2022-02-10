#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Reload Xresources for colors
xrdb ~/.Xresources

# Wait until the processes have been shut down
sleep 1
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top bar
polybar -r -c ~/.config/polybar/config.ini top &