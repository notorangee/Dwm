#! /bin/sh

#蓝牙定义
BLUE_DEVICES=$(bluetoothctl devices | awk '{print $2}' 2>/dev/null)
BLUE_ICON=""
BLUE_STATUS="NDC"

BLUE_CHECK(){
  for device in ${BLUE_DEVICES}
  do
    if [[ "$( bluetoothctl info $device | grep 'Connected' | awk -F ': ' '{print $2}' 2>/dev/null)" = "yes" ]]; then
      local device_name=$(bluetoothctl info $device | awk '/Alias/' | awk -F ': ' '{print $2}' 2>/dev/null)
      if [[ "$device_name" = "Keyboard K380" ]]; then
        xset r rate 300 30 2>/dev/null #设置蓝牙键盘在唤醒时的响应速度
      fi
      if [[ $BUTTON == 1 ]]; then
        printf "%s\n" "${device_name}"
      fi
      BLUE_ICON=""
      BLUE_STATUS="CTD"
    fi
  done
  if [[ "$BLUE_STATUS" = "NDC" && $BUTTON == 1 ]]; then
    printf "%s\n" "无设备连接"
  fi
}

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '蓝牙设备')" "$(BLUE_CHECK)" ;;
	2) blueman-manager ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

BLUE_CHECK

printf "%s\n" "${BLUE_ICON}:${BLUE_STATUS}"
