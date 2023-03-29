#! /bin/sh

case $BUTTON in
	1) notify-send "vol1" ;;
	2) notify-send "vol2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

VOL_SWITCH=$( pulseaudio-ctl full-status | awk -F " " '{print $2}' )
if [ "$VOL_SWITCH" = "no" ];then
	VOL=$( pulseaudio-ctl full-status | awk -F " " '{print $1}' )
else
	VOL="xx"
fi
VOL_STATUS="ﰝ:$VOL%"

printf "%s\n" "$VOL_STATUS"
