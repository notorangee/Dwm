#! /bin/sh

WIFI_Dispose=( "WIFI:" "设备:" "MAC地址:" "IPV4:")
WIFI_getInfo=$(nmcli device show wlan0 | grep -e "GENERAL.CONNECTION" -e "GENERAL.DEVICE" \
  -e "GENERAL.HWADDR" -e "IP4.GATEWAY" | sort | awk -F ": +" '{print $2}' 2>/dev/null)

i=0
WIFI_Info(){
  for row in ${WIFI_getInfo}
  do
    printf "\t\t%-5s%-1s\n" ${WIFI_Dispose[$i]} ${row}
    i=`expr $i + 1`
  done
}

WIFI_CONNECTION(){
  nmcli device wifi rescan 2>/dev/null && nmcli device wifi list >/dev/null && nmcli device wifi \
    connect AvaOra password pom59641874\"@\" >/dev/null && printf '\t\t       %s\n' '连接到AvaOra'
  if [[ $? -ne 0 ]]; then
    nmcli device wifi connect A601_5G password 12345678@601 >/dev/null \
      && printf '\t%s\n' '未发现AvaOra! 连接到A601_5G'
  fi
}

case $BUTTON in
  1) notify-send "$(printf '\t\t%s\n' 'WIFI详情')" "$(WIFI_Info)" ;;
  2) notify-send "$(printf '\t\t%s\n' 'Wifi连接信息')" "$(WIFI_CONNECTION)" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#WIFI定义
WIFI_ICON=''
NO_WIFI_ICON='睊'
WIFI_STATUS="$NO_WIFI_ICON:0%"
percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'\
  | xargs | awk '{print $1 }' 2>/dev/null)"
WIFI_Device=$( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' 2>/dev/null )
if [ $WIFI_Device = "wlan0" ]; then
  if [ !$percentage ]; then
    
    if $(ping -c 1 archlinux.org >/dev/null); then
	    WIFI_STATUS="$WIFI_ICON:$percentage%"
    else
	    WIFI_STATUS="$NO_WIFI_ICON:$percentage%"
    fi

  fi
fi

printf "%s\n" "${WIFI_STATUS}"
