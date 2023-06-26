#! /bin/sh

#背光定义
# OpenGL vendor string: AMD
# OpenGL vendor string: NVIDIA Corporation
BACKLIGHT_MODE=$([[ "$( glxinfo | grep 'OpenGL vendor' | awk -F ': ' '{printf $2}' | cut -d '%' -f 1 )" = "AMD" ]] \
  && echo "amdgpu_bl0" || echo "nvidia_0")
BACKLIGHT_COUNT=$( cat /sys/class/backlight/$BACKLIGHT_MODE/brightness )
BACKLIGHT_INFO=$( [[ "$BACKLIGHT_MODE" = "amdgpu_bl0" ]] && echo "scale=0; $BACKLIGHT_COUNT / 2.55" | bc \
  || echo "scale=1; $BACKLIGHT_COUNT * 1" | bc)
BACKLIGHT_Icon="ﱧ"
BACKLIGHT_Status="${BACKLIGHT_INFO%.*}"

case $BUTTON in
  1) notify-send "$( light -A 5 || printf '\t\t\t%s\n' '增大屏幕背光错误，请查看日志')" ;;
  2) notify-send "$( light -U 5 || printf '\t\t\t%s\n' '减小屏幕背光错误，请查看日志')" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

echo "${BACKLIGHT_Icon}:${BACKLIGHT_Status}%"
