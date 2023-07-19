#! /bin/sh

case $BLOCK_BUTTON in
	1) notify-send "fcitx1" ;;
	2) notify-send "fcitx2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

INPUT_READ=$( fcitx5-remote 2>/dev/null )
INPUT_STATUS="英"
if [ $INPUT_READ -eq 2 ]; then
	INPUT_STATUS="中"
fi

printf "%s\n" "${INPUT_STATUS}"
