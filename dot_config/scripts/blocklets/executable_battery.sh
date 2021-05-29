is_charging=$(acpi -b | grep Charging -c)

battery_life() {
  acpi \
    | cut -d',' -f2 \
    | sed 's/ //g' \
    | paste -s -d " "
}

add_action(){
  stdin=$(cat -)
  action=$1
  echo "%{A1:$action:}$stdin%{A}"
}

on_click(){
  notify-send "$(acpi -b)"
}

charge_icon=""
if [[ $is_charging -eq 1 ]]; then
  charge_icon="🗲" 
fi

echo "$(battery_life)$charge_icon"
  #| colorise
  #| add_action "$(on_click)"

