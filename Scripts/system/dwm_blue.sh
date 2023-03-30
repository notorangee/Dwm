#! /bin/sh

#蓝牙定义
BLUE_DEVICES=$(bluetoothctl devices | awk '{print $2}')
BLUE_STATUS=""

BLUE_CHECK(){
  for device in ${BLUE_DEVICES}
  do
    if [[ "$( bluetoothctl info $device | grep 'Connected' | awk -F ': ' '{print $2}')" = "yes" ]]; then
      printf "\t\t\t   %s\n" "$( bluetoothctl info $device | awk '/Alias/' | awk -F ': ' '{print $2}' )"
    fi
  done
}

case $BUTTON in
  1) notify-send "$(printf '\t\t\t%s\n' '蓝牙设备')" "$(BLUE_CHECK)" ;;
	2) notify-send "蓝牙管理" && blueman-manager & ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

if [ "$BLUE_DEVICES" ]; then
        BLUE_STATUS=":CTD"
else
	BLUE_STATUS=":NDC"
fi

printf "%s\n" "${BLUE_STATUS}"
