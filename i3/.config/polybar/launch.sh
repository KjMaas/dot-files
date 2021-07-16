#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1
echo "---" | tee -a /tmp/polybar1.log
polybar top 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
