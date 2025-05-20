#!/bin/bash

temperatureB=$(echo "$(cat /sys/class/hwmon/hwmon1/in0_input) / 1000" | bc)
temperatureC=$(echo "$(cat /sys/class/hwmon/hwmon4/temp1_input) / 1000" | bc)

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '温度信息')" "$(printf '%s%d%s\n' \
    '电池温度:' $temperatureB '°C')""$(printf '\n%s%d%s\n' 'CPU温度:' $temperatureC '°C')";;
	2) notify-send "temp2" ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

printf ":%d°C\n" "${temperatureC}"
