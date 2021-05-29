i3-msg restart
xrdb ~/.Xresources
~/.fehbg

# restart polybar (requires i3)
polybar-msg cmd restart &&
  ~/.config/polybar/launch.sh & disown

# restart picom (requires i3)
killall picom;
picom & disown


