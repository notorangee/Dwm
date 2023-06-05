#! /bin/sh

#背光定义
# OpenGL renderer string: AMD Radeon Graphics (renoir, LLVM 15.0.7, DRM 3.52, 6.3.5-zen1-1-zen)
BACKLIGHT_INFO=$( echo "scale=1; ($( cat /sys/class/backlight/nvidia_0/brightness )) * 1" | bc 2>/dev/null)
BACKLIGHT_Icon="ﱧ"
BACKLIGHT_Status="${BACKLIGHT_INFO%.*}"

case $BUTTON in
  1) notify-send "$( light -A 5 || printf '\t\t\t%s\n' '增大屏幕背光错误，请查看日志')" ;;
  2) notify-send "$( light -U 5 || printf '\t\t\t%s\n' '减小屏幕背光错误，请查看日志')" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

echo "${BACKLIGHT_Icon}:${BACKLIGHT_Status}%"
