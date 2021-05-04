#!/usr/bin/bash

if [ -z $1 ]; then
	# echo "Usage: $0 <name of hidden scratchpad window>"
	exit 1
fi
    
pids=$(xdotool search --class ${1})
for pid in $pids; do
	# echo "Kill $pid"
	# bspc node $pid -k # <-- doesn't kill processes abandoned by bspwm
	xkill -id $pid
done

