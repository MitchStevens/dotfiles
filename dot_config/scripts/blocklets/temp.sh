temp=$(curl wttr.in/Canberra?format="%t" -s)
if ((${#temp} > 4)); then
  echo "err"
else
  echo $temp
fi
