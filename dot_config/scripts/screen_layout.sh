#!/usr/bin/env bash
set -euo pipefail

num_screens="$(xrandr | grep " connected" | wc -l)"

DUAL_SCREEN =

case $num_screens in
    1) ~/.screenlayout/single_screen.sh ;;
    1) ~/.screenlayout/vertical_screen.sh ;;
    2) ~/.screenlayout/left_screen.sh ;;
    *)
esac

~/.fehbg

dual_screen() {
xrandr \
    --output eDP1\
        --primary \
        --mode 1366x768\
        --pos 0x312\
        --rotate normal\
    --output HDMI1\
        --mode 1920x1080\
        --pos 1366x0\
        --rotate normal
}
