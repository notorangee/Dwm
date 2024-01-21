#! /bin/sh

#蓝牙定义
BLUE_DEVICES=$(bluetoothctl devices | awk '{print $2}' 2>/dev/null)
BLUE_ICON="󰂲"
BLUE_STATUS="NDC"

function BLUE_CHECK {
  for device in ${BLUE_DEVICES}
  do
    if [[ "$( bluetoothctl info $device | grep 'Connected' | awk -F ': ' '{print $2}' 2>/dev/null)" = "yes" ]]; then
      local device_name=$(bluetoothctl info $device | awk '/Alias/' | awk -F ': ' '{print $2}' 2>/dev/null)
      BLUE_ICON="󰂱"
      BLUE_STATUS="CTD"
      if [[ "$device_name" = "Keyboard K380" ]]; then
        xset r rate 300 30 2>/dev/null #设置蓝牙键盘在唤醒时的响应速度
      fi
      if [[ $BLOCK_BUTTON == 1 ]]; then
        printf "%s\n" "${device_name}"
      fi
    fi
  done
  if [[ "$BLUE_STATUS" = "NDC" && $BLOCK_BUTTON == 1 ]]; then
    printf "%s\n" "无设备连接"
  fi
}

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '蓝牙设备')" "$(BLUE_CHECK)" ;;
	3) blueman-manager ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

if [[ $BLOCK_BUTTON -eq 1 ]]; then
  BLOCK_BUTTON=0
fi

BLUE_CHECK

printf "%s\n" "${BLUE_ICON}:${BLUE_STATUS}"
