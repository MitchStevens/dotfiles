#!/bin/bash
export POLYBAR_HEIGHT=20

inner=0
top=0
bottom=0
horizontal=0

# POLYBAR_HEIGHT + top == bottom

case $1 in
  0) ;;
  1) inner=10
     top=0
     bottom=10
     horizontal=10;;
  2) inner=10
     top=0
     bottom=$(($POLYBAR_HEIGHT + $inner))
     horizontal="100" ;;
  *)
esac

echo "$inner $top $bottom $horizontal"


i3-msg "gaps inner      all set $inner"
i3-msg "gaps top        all set $top"
i3-msg "gaps bottom     all set $bottom"
i3-msg "gaps horizontal all set $horizontal"

# Scale up polybar

border=$(($horizontal + $inner))
export POLYBAR_HORIZONTAL_BORDER="$border"
echo "$POLYBAR_HORIZONTAL_BORDER"
$HOME/.config/polybar/launch.sh
