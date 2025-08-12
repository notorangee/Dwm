#! /bin/sh

case $BLOCK_BUTTON in
	1) $(fcitx5-remote -t >/dev/null) ;;
  3) $(fcitx5-configtool) ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

INPUT_READ=$( fcitx5-remote 2>/dev/null )
INPUT_STATUS="EN"
if [ $INPUT_READ -eq 2 ]; then
	INPUT_STATUS="ZH"
fi

printf "%s\n" "${INPUT_STATUS}"
