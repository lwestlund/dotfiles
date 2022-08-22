#!/usr/bin/env bash

# Terminate already running bar instances.
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bars
for m in $(polybar --list-monitors | cut -d":" -f1); do
    a=$(polybar --list-monitors | grep "$m" | grep "primary")
    if [[ -n "$a" ]]; then
        log=/tmp/polybar_bottom_primary.log
        MONITOR=$m polybar -r bottom_primary >> $log 2>&1 &
    else
        log=/tmp/polybar_bottom_secondary.log
        MONITOR=$m polybar -r bottom_secondary >> $log 2>&1 &
    fi
    echo "---" | tee -a $log
done

echo "Bars launched..."
