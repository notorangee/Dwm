#! /bin/sh

killall ncmpcpp 2>/dev/null
killall cava 2>/dev/null
if [ $? -ne 0 ]; then
  alacritty -t ncmpcpp -e ncmpcpp & \
  alacritty -t MusicVisua -o window.dimensions.columns=50 window.dimensions.lines=20 -e cava -p $HOME/.config/cava/dwm
fi

