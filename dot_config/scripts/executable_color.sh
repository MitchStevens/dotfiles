num=$1
case $1 in
  "black"        ) num="0" ;;
  "red"          ) num="1" ;;
  "green"        ) num="2" ;;
  "yellow"       ) num="3" ;;
  "blue"         ) num="4" ;;
  "purple"       ) num="5" ;;
  "cyan"         ) num="6" ;;
  "white"        ) num="7" ;;
  "brightBlack"  ) num="8" ;;
  "brightRed"    ) num="9" ;;
  "brightGreen"  ) num="10" ;;
  "brightYellow" ) num="11" ;;
  "brightBlue"   ) num="12" ;;
  "brightPurple" ) num="13" ;;
  "brightCyan"   ) num="14" ;;
  "brightWhite"  ) num="15" ;;
esac

xrdb -query | grep "\*.color$num:" | cut -f2
