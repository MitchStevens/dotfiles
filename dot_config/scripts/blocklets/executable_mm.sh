#!/bin/bash

function colorise() {
  c=""
  text=$(cat -)
  case $new_eps in
    -*) c=$(~/.scripts/color.sh "red") ;;
    0)  c=$(~/.scripts/color.sh "blue");;
    *)  c=$(~/.scripts/color.sh "green") ;;
  esac

  if [[ -z $c ]]; then
    echo " $text "
  else
    echo "%{B${c}} $text %{B-}"
  fi
}

message() {
  case $new_eps in
    -*) echo "err" ;;
    0) echo "no eps" ;;
    1) echo "1 new episode!" ;;
    *) echo "$new_eps new episodes!" ;;
  esac
}

num_episodes=87
cheekys_episodes=`curl -s 'https://cheekyvideos.net/' | grep 'Murdoch Murdoch Video Archive' | sed 's/[^0-9]*//g'`
new_eps=$(($cheekys_episodes - $num_episodes))

message
