#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
#polybar primary &

PRIMARY=$(xrandr -q | grep primary | cut -d' ' -f1)

for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
	if [ "$m" = "$PRIMARY" ] ; then
		MONITOR=$m polybar primary &
	else
		MONITOR=$m polybar secondary &
	fi
done
