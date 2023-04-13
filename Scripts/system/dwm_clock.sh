#! /bin/sh

Clock_Info=$(date +'%F %A %n                                    %T' 2>/dev/null)

case $BUTTON in
	1) notify-send "                        当前时间" "\
                         ${Clock_Info}" ;;
	2) notify-send "clock2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

LOCALTIME=$( date +'%H:%M' 2>/dev/null )
printf "%s \n" "${LOCALTIME}"
