#!/bin/bash

# Returns the first currently active monitor.

monitor=$(xrandr --query | grep "*+" -B 1 | cut -d" " -f1 | cut -d$'\n' -f1)
echo "$monitor"
