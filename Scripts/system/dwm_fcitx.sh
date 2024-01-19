#! /bin/sh

case $BLOCK_BUTTON in
	1) $(fcitx5-remote -t >/dev/null) ;;
  2) $(fcitx5-configtool) ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

INPUT_READ=$( fcitx5-remote 2>/dev/null )
INPUT_STATUS="英"
if [ $INPUT_READ -eq 2 ]; then
	INPUT_STATUS="中"
fi

printf "%s\n" "${INPUT_STATUS}"
