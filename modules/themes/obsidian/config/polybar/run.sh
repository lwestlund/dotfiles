#!/usr/bin/env bash

# Terminate already running bar instances.
pkill -u $UID polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bars
for m in $(polybar --list-monitors | cut -d":" -f1); do
    a=$(polybar --list-monitors | grep "$m" | grep "primary")
    if [[ -n "$a" ]]; then
        log=/tmp/polybar_bottom_primary.log
        MONITOR=$m polybar bottom_primary 2>&1 | tee -a $log & disown
    else
        log=/tmp/polybar_bottom_secondary.log
        MONITOR=$m polybar bottom_secondary 2>&1 | tee -a $log 2>&1 & disown
    fi
    echo "---" | tee -a $log
done

echo "Polybars launched..."
