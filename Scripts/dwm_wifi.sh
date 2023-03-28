#! /bin/sh

case $BUTTON in
	1) notify-send "wifi1" ;;
	2) notify-send "wifi2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#WIFI定义
WIFI_ICON=''
NO_WIFI_ICON='睊'
WIFI_STATUS="$NO_WIFI_ICON:0%"
percentage="0%"
if [ $( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' ) = "wlan0" ] 2>/dev/null; then
        percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'| xargs | awk '{print $1 }')"
        if [ !$percentage ]
        then
		WIFI_STATUS="$WIFI_ICON:$percentage%"
        fi
fi

printf "%s\n" "${WIFI_STATUS}"
