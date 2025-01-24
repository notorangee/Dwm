#! /bin/zsh

name_pid=$(pgrep -fn dwm_musicinfo.sh)
[[ ? -eq 0 ]] && kill -9 ${name_pid} 2>/dev/null
killall ncmpcpp 2>/dev/null
killall cava 2>/dev/null
if [ $? -ne 0 ]; then
  alacritty -t ncmpcpp -e ncmpcpp & \
  alacritty -t MusicVisua -e cava -p $HOME/.config/cava/dwm & \
  alacritty -t MusicInfo -e $HOME/Dwm/Scripts/system/dwm_musicinfo.sh
fi

