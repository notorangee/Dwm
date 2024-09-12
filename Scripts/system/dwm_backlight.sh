#! /bin/sh

case $BLOCK_BUTTON in
  1) light -A 5 || notify-send "$( printf '%s\n' '增大屏幕背光错误，请查看日志')" ;;
  3) light -U 5 || notify-send "$( printf '%s\n' '减小屏幕背光错误，请查看日志')" ;;
  4) light -A 5 ;;
  5) light -U 5 ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

#背光定义
# OpenGL vendor string: AMD
# OpenGL vendor string: NVIDIA Corporation
BACKLIGHT_MODE=$([[ "$( glxinfo | grep 'OpenGL vendor' | awk -F ': ' '{printf $2}' | cut -d '%' -f 1 )" = "AMD" ]] \
  && echo "amdgpu_bl0" || echo "nvidia_0")
BACKLIGHT_COUNT=$( cat /sys/class/backlight/$BACKLIGHT_MODE/brightness )
BACKLIGHT_INFO=$( [[ "$BACKLIGHT_MODE" = "amdgpu_bl0" ]] && echo "scale=2; $BACKLIGHT_COUNT / 255 * 100" | bc \
  || echo "scale=0; $BACKLIGHT_COUNT * 1" | bc)
BACKLIGHT_Icon="󰝩"

printf '%s%d%s' "${BACKLIGHT_Icon}:" ${BACKLIGHT_INFO} "%"
