#!/bin/bash

DIR=$HOME/Pictures/background/
PICS=($(find ${DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}
NEWRANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}


change_swww(){
  pkill swaybg
  swww query || swww init
  swww img ${RANDOMPICS} -o eDP-1 --transition-fps 60 --transition-type wipe --transition-angle 135 --transition-duration 3
  swww img ${NEWRANDOMPICS} -o HDMI-A-1 --transition-fps 60 --transition-type wipe --transition-angle 135 --transition-duration 3
}

change_current(){
  if pidof swaybg >/dev/null; then
    change_swaybg
  else
    change_swww
  fi
}

switch(){
  if pidof swaybg >/dev/null; then
    change_swww
  else
    change_swaybg
  fi
}

case "$1" in
	"swww")
		change_swww
		;;
  "s")
		switch
		;;
	*)
		change_current
		;;
esac

