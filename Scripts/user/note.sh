#! /bin/sh

case $BLOCK_BUTTON in
  1) xournalpp || notify-send -a "NoteBook" -i "󰠮" "打开笔记错误, 请检查日志" 2>/dev/null ;;
	2) notify-send "note2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

Note_Icon="󰠮"
printf "%s\n" "${Note_Icon}"


