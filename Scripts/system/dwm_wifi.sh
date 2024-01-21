#! /bin/sh

WIFI_DEV=0 # laptop = 0 or tablet = 1
WIFI_Dispose=( "WIFI:" "设备:" "MAC地址:" "IPV4:")
WIFI_getInfo=$(nmcli device show $( [[ $WIFI_DEV -eq 0 ]] && echo "wlan0" || echo "wlp1s0" ) \
  | grep -e "GENERAL.CONNECTION" -e "GENERAL.DEVICE" \
  -e "GENERAL.HWADDR" -e "IP4.ADDRESS\[1\]" | sort | awk -F ": +" '{print $2}' 2>/dev/null)

i=0
WIFI_Info(){
  for row in ${WIFI_getInfo}
  do
    printf "%-5s%-1s\n" ${WIFI_Dispose[$i]} ${row}
    i=`expr $i + 1`
  done
}

WIFI_CONNECTION(){
  nmcli device wifi rescan 2>/dev/null && nmcli device wifi list >/dev/null && nmcli device wifi \
    connect Ora password pom59641874@ hidden yes >/dev/null && printf '%s\n' '连接到Ora'
  if [[ $? -ne 0 ]]; then
    nmcli device wifi connect A601_5G password 12345678@601 >/dev/null \
      && printf '%s\n' '未发现Ora! 连接到A601_5G'
  fi
}

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' 'WIFI详情')" "$(WIFI_Info)" ;;
  3) notify-send "$(printf '%s\n' 'Wifi连接信息')" "$(WIFI_CONNECTION)" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#WIFI定义
WIFI_ICON=''
NO_WIFI_ICON='󰖪'
WIFI_STATUS="$NO_WIFI_ICON:0%"
percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'\
  | xargs | awk '{print $1 }' 2>/dev/null)"
WIFI_Device=$( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' 2>/dev/null )
if [ $WIFI_Device = $( [[ $WIFI_DEV -eq 0 ]] && echo "wlan0" || echo "wlp1s0" ) ]; then
  if [ !$percentage ]; then
    
    if $(ping -c 1 archlinux.org >/dev/null); then
	    WIFI_STATUS="$WIFI_ICON:$percentage%"
    else
	    WIFI_STATUS="$NO_WIFI_ICON:$percentage%"
    fi

  fi
fi

printf "%s\n" "${WIFI_STATUS}"
