#! /bin/sh

Open_Trayer(){
  killall trayer 2>/dev/null;
  if [ $? -ne 0 ]; then
  	trayer --transparent true --expand false --edge top --align center --width 32 --height 25 --distance 2 \
      --distancefrom top --SetDockType false --tint 0x00000000 --iconspacing 10 &
  fi
}

case $BLOCK_BUTTON in
  1) Open_Trayer && Trayer_Lock="true" 2>/dev/null ;;
	2) notify-send "Trayer2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

TrayerIcon="󰀻"
printf "%s\n" "$TrayerIcon"

