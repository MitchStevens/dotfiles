#!/usr/bin/env python3
import os

monitors = os.system("polybar -M").readlines()
num_screens = int(len(monitors))

if num_screens == 1:
    pass
elif num_screens == 2:
    pass
else:
    pass



def run_xrandr():
    xrandr_flags = []
    for monitor in monitors:
        f"--output "




os.system("~/.fehbg")
os.system("polybar-msg cmd hjrestart")
