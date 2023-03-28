#! /bin/sh

case $BUTTON in
	1) notify-send "clock1" ;;
	2) notify-send "clock2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

LOCALTIME=$( date +'%F %A %H:%M' )
printf "%s \n" "${LOCALTIME}"
