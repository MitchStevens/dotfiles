#!/bin/bash

choice=$(find $1 | dmenu)

xdg-open $choice:w

