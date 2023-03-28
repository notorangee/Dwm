#! /bin/sh

#背光定义
BACKLIGHT_INFO=`echo "scale=1; ($( cat /sys/class/backlight/intel_backlight/brightness ) / 15) * 1" | bc`
BACKLIGHT="ﱧ:${BACKLIGHT_INFO%.*}%"

echo "${BACKLIGHT}"
