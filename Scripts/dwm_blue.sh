#! /bin/sh

case $BUTTON in
	1) notify-send "blue1" ;;
	2) notify-send "blue2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#蓝牙定义
BLUE_DEVICE1=$( bluetoothctl info | awk '/Alias/' | awk -F ' ' '{print $2}' )
BLUE_STATUS=""

if [ $BLUE_DEVICE1 ]; then
        BLUE_STATUS=":$BLUE_DEVICE1"
else
	BLUE_STATUS=":NDC"
fi

printf "%s\n" "${BLUE_STATUS}"
