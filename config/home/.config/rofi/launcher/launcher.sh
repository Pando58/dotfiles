#!/usr/bin/env bash

emoji=$(type -p rofimoji)

rofi -show drun -theme $(dirname "$0")/style.rasi -modi "drun,run,emoji:$emoji,filebrowser,window"
