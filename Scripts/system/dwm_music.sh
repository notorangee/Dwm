#! /bin/zsh

name_pid=$(pgrep -fn dwm_musicinfo.sh)
cava_pid=$(pgrep -fn cava)
[[ ? -eq 0 ]] && kill -9 ${name_pid} 2>/dev/null
killall ncmpcpp 2>/dev/null
kill -9 ${cava_pid} 2>/dev/null
if [ $? -ne 0 ]; then
  alacritty -t MusicWin -e ncmpcpp & \
  alacritty -t MusicVisua -e cava -p $HOME/.config/cava/dwm & \
  alacritty -t MusicInfo -e $HOME/Dwm/Scripts/system/dwm_musicinfo.sh
fi

