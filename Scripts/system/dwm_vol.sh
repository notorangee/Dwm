#! /bin/sh

ps -A | grep ncmpcpp >/dev/null
if [[ $? -eq 0 ]]; then
  PLAY_STATUS=true
fi

case $BLOCK_BUTTON in
  1) mpc pause-if-playing >/dev/null \
        && notify-send -t 3000 "󰝚暂停音乐" "$(printf '%s %s %s\n' $(mpc current))" \
        || (mpc play >/dev/null && notify-send -t 3000 "󰝚播放音乐" "$(printf '%s %s %s\n' $(mpc current))");;
	2) notify-send -t 5000 "󰝚音乐信息" "$(printf '%s %s %s\n' $(mpc current))" ;;
	3) mpc next >/dev/null && [[ $PLAY_STATUS ]] || notify-send -t 1500 "󰝚下一首音乐" "$(printf '%s %s %s\n' $(mpc current))" ;;
  4) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+;;
  5) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-;;
	6) alacritty -e $EDITOR "$0" ;;
esac

VOL_SWITCH=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F '[][]' '{print $2}' 2>/dev/null )
VOL_VAL=$(echo "scale=2;$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F ' ' '{print $2}') * 100 " | bc 2>/dev/null)
if [ "$VOL_SWITCH" = "MUTED" ];then
	VOL="xx"
else
  VOL="$(printf '%.0f\n' $VOL_VAL)"
fi
VOL_STATUS="󰕾:$VOL%"

printf "%s\n" "$VOL_STATUS"
