#! /bin/sh

WIFI_MAIN="Ora"
WIFI_RESERVE="PCDN_5G"
WIFI_DEV=0 # laptop = 0 or tablet = 1
WIFI_DISPOSE=( "WIFI:" "设备:" "MAC地址:" "IPV4:" "网关:")
WIFI_getStatus=$(nmcli device status | grep "wlan0" | awk '{print $3}')

WIFI_getInfo=$(nmcli device show $( [[ $WIFI_DEV -eq 0 ]] && echo "wlan0" || echo "wlp1s0" ) \
  | grep -e "GENERAL.CONNECTION" -e "GENERAL.DEVICE" \
  -e "GENERAL.HWADDR" -e "IP4.ADDRESS\[1\]" -e IP4.GATEWAY | sort | awk -F ": +" '{print $2}' 2>/dev/null)

i=0
WIFI_Info(){
  if [ $WIFI_getStatus = "unavailable" ]; then
    echo "WIFI已关闭"
    return
  fi
  for row in ${WIFI_getInfo}
  do
    printf "%-5s%-1s\n" ${WIFI_DISPOSE[$i]} ${row}
    (( i++ ))
  done
}

WIFI_Connect(){
  if [ $WIFI_getStatus = "unavailable" ]; then
    echo "WIFI已关闭"
    return
  fi
  nmcli device wifi rescan 2>/dev/null
  timeout=3
  while [[ $timeout -gt 0 ]]; do
    (( timeout-- ))
    nmcli connection up $WIFI_MAIN >/dev/null && { echo "连接到$WIFI_MAIN"; return 0; }
    sleep 1s
  done
  nmcli connection up $WIFI_RESERVE >/dev/null \
    && { echo "未发现$WIFI_MAIN! 连接到$WIFI_RESERVE" ; return 0;}
  echo "无法连接指定的WIFI设备!"
}

WIFI_Turn(){
  if [ $WIFI_getStatus = "unavailable" ]; then
    nmcli radio wifi on && echo "WIFI开启"
    sleep 1s
    WIFI_getStatus=$(nmcli device status | grep "wlan0" | awk '{print $3}')
    WIFI_Connect
  else
    nmcli radio wifi off && echo "WIFI关闭"
  fi
}

WIFI_Define(){
  WIFI_ICON=''
  WIFI_ICON_ALERT='󱚵'
  NO_WIFI_ICON='󰖪'
  WIFI_Status="$NO_WIFI_ICON:xx%" 
  WIFI_getStatus=$(nmcli device status | grep "wlan0" | awk '{print $3}')
  if [ $WIFI_getStatus != "connected" ]; then
    printf "%s\n" "${WIFI_Status}" 
    return
  fi

  percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'\
    | xargs | awk '{print $1 }' 2>/dev/null)"
  WIFI_Device=$( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' 2>/dev/null )
  WIFI_Type=$( [ $WIFI_DEV -eq 0 ] && echo "wlan0" || echo "wlp1s0" )
  if [ $WIFI_Device = "$WIFI_Type" ]; then
    if [ !$percentage ]; then
      if $(timeout 2s ping -c 1 -w 1 "9.9.9.9" >/dev/null); then
        WIFI_Status="$WIFI_ICON:$percentage%" 
      else
        WIFI_Status="$WIFI_ICON_ALERT:$percentage%" 
      fi
      printf "%s\n" "${WIFI_Status}" 
    fi
  fi
}

case $BLOCK_BUTTON in
  1) notify-send -t 5000 "$(printf '%s\n' 'WIFI详情')" "$(WIFI_Info)" ;;
  2) notify-send -t 3000 "$(printf '%s\n' 'wIFI状态切换')" "$(WIFI_Turn)" ;;
  3) notify-send -t 1500 "$(printf '%s\n' 'WIFI连接')" "$(WIFI_Connect)" ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

WIFI_Define
