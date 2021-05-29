tmpfile="$(mktemp).pdf"
touch "$tmpfile"
chmod 777 "$tmpfile"
update_file="pandoc -f markdown -t pdf -o $tmpfile $1"

$update_file
$EDITOR $1 &&
zathura $tmpfile & \
  echo "$1" | entr -s "$update_file"
