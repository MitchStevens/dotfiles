#!/bin/bash

# generate files at ./color/<COLOR>

colors=($(xrdb -query | grep '*color*' | awk '{print $NF}'))
names=(black red green yellow blue magenta cyan light_grey dark_grey light_red light_green light_yellow light_blue light_magenta light_cyan white)

if [ ! -d "~/.color" ]; then
  mkdir ~/.color
  for name in $names; do
    touch "~/.color/$name"
  done
fi


for i in $(seq 0 15); do
  touch "~/.color/${names[$i]}"
  echo "${colors[$i]}" > "~/.color/${names[$i]}"
done
