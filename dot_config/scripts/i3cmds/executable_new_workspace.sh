# open a new workspace in i3

largest_workspace=`i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1`

i3-msg workspace $(($largest_workspace + 1))
