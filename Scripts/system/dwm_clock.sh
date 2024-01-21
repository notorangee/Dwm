#! /bin/sh

Clock_Info=$(date +'%F %A %n %T' 2>/dev/null)

case $BLOCK_BUTTON in
	1) notify-send "当前时间" "${Clock_Info}" ;;
	3) notify-send "clock2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

LOCALTIME=$( date +'%H:%M' 2>/dev/null )
printf "%s" "${LOCALTIME}"
