#! /bin/sh

case $BLOCK_BUTTON in
  1) flameshot gui || notify-send -a "flameshot" -i "󱣴" "打开截图错误, 请检查日志"  2>/dev/null ;;
	2) notify-send "flameshot2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

FlameshotIcon="󱣴"

printf "%s\n" "$FlameshotIcon"
