#! /bin/sh

WIFI_Dispose=( "WIFI:" "设备:" "MAC地址:" "IPV4:")
WIFI_getInfo=$(nmcli device show wlan0 | grep -e "GENERAL.CONNECTION" -e "GENERAL.DEVICE" \
  -e "GENERAL.HWADDR" -e "IP4.GATEWAY" | sort | awk -F ": +" '{print $2}')

i = 0
WIFI_Info(){
  for row in ${WIFI_getInfo}
  do
    printf "\t\t%-5s%-1s\n" ${WIFI_Dispose[$i]} ${row}
    i=`expr $i + 1`
  done
}

case $BUTTON in
  1) notify-send "$(printf '\t\t%s\n' 'WIFI详情')" "$(WIFI_Info)" ;;
  2) notify-send "$((nmcli device wifi rescan && nmcli device wifi list && nmcli device wifi \
    connect AvaOra password pom59641874\"@\" ) >/dev/null)" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#WIFI定义
WIFI_ICON=''
NO_WIFI_ICON='睊'
WIFI_STATUS="$NO_WIFI_ICON:0%"
percentage="0%"
if [ $( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' ) = "wlan0" ] 2>/dev/null; then
        percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'| xargs | awk '{print $1 }')"
        if [ !$percentage ]; then
          
          if ping -c 1 archlinux.org >/dev/null 2>&1 ; then
		        WIFI_STATUS="$WIFI_ICON:$percentage%"
          else
		        WIFI_STATUS="$NO_WIFI_ICON:$percentage%"
          fi

        fi
fi

printf "%s\n" "${WIFI_STATUS}"
