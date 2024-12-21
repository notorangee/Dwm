#! /bin/sh

TIMEZONE="Asia/Shanghai" # use tzselect command to query
Clock_Info=$(TZ="$TIMEZONE" date +'%F %A %n %T' 2>/dev/null)

case $BLOCK_BUTTON in
	1) notify-send "当前时间" "${Clock_Info}" ;;
	3) notify-send "clock2" ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

LOCALTIME=$( TZ="$TIMEZONE" date +'%H:%M' 2>/dev/null )
printf "%s" "${LOCALTIME}"
