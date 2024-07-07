#!/bin/bash

temperature=$(echo "$(cat /sys/class/hwmon/hwmon2/temp1_input) / 1000" | bc)

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '温度信息')" "$(printf '%s%s\n' \
    '机身温度:' $temperature)""$(printf '\n%s%s\n' 'CPU温度:' $(printf '%.0f%s' \
    60))";;
	2) notify-send "temp2" ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

printf ":%d°C\n" "${temperature}"
