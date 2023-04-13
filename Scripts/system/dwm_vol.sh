#! /bin/sh

case $BUTTON in
  1) (mpc pause-if-playing >/dev/null;
    if [[ $? -ne 0 ]]; then
      mpc play >/dev/null && notify-send "󰝚播放音乐" "$(printf '%s %s %s\n' $(mpc current))"
    else
      mpc pause >/dev/null && notify-send "󰝚暂停音乐" "$(printf '%s %s %s\n' $(mpc current))" 
      fi) ;;
	2) pulseaudio-ctl mute && notify-send "󰎊" "静音" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

VOL_SWITCH=$( pulseaudio-ctl full-status | awk -F " " '{print $2}' 2>/dev/null )
if [ "$VOL_SWITCH" = "no" ];then
	VOL=$( pulseaudio-ctl full-status | awk -F " " '{print $1}' 2>/dev/null )
else
	VOL="xx"
fi
VOL_STATUS="ﰝ:$VOL%"

printf "%s\n" "$VOL_STATUS"
