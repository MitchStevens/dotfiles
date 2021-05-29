#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
config_root="$HOME/.config/polybar"

for m in $(polybar -m | cut -d':' -f1); do
  export POLYBAR_MONITOR="$m"
  echo $m
  polybar "master"  -c "$config_root/master.conf" &
  #polybar "infobar" -c "infobar.conf"
done
echo "Polybar Launched"
