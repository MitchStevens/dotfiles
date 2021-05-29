#!/usr/bin/env bash
set -euo pipefail

layout=$(ls ~/.screenlayout | rofi -dmenu)
"$HOME/.screenlayout/$layout"

~/.fehbg
$HOME/.config/polybar/launch.sh
