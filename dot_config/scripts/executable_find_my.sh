DELIM=" * "

choose_file(){
  rofi \
    -p "Choose file: " \
    -i \
    -markup-rows \
    -dmenu | sed "s/ \* /\t/g" | cut -f2
}

open_with(){
  file=$(cat -)
  if [ -n "$file" ]; then
    notify-send "Opening $file with $1"
    $($1 "$file")
  fi
}

title() {
  while read -r line; do
    filename=$(echo "$line" | awk -F/ '{print $NF}');
    echo -en "<b>$filename</b>$DELIM$line\n";
  done
}

find_pdfs(){
  find ~/Books ~/.notes/ ~/Downloads ~/Documents \
    -name "*.pdf" | title
}

find_videos(){
  find ~/Videos ~/Downloads \
       -name "*.mp4" \
    -o -name "*.webm" \
    -o -name "*.mkv" | title
}

find_markdown(){
  find ~/.notes ~/Documents \
      -name "*.md" \
   -o -name "*.txt" | title
}

# Finders
case $1 in
  "pdf")
    find_pdfs | choose_file | open_with zathura 
    ;;
  "markdown")
    find_markdown | choose_file | open_with ~/.config/scripts/show_md.sh
    ;;
  "videos")
    find_videos | choose_file | open_with vlc
    ;;
esac
