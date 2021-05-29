#!/bin/bash

program_name=$(top -b -n1 -u $USER -o %MEM | 
  tail -n +8 | 
  awk '{print $NF}' |  
  awk '!uniq[$0]++' |
  dmenu 'Kill Program:')

pgrep $program_name | xargs fortune

