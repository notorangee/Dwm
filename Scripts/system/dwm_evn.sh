#! /bin/sh
#dwm启动执行
xrandr --auto
xset r rate 300 30
picom --experimental-backends -b & 2>/dev/null
killall fcitx5 2>/dev/null
fcitx5 -d & 2>/dev/null
flameshot & 2>/dev/null
#caffeine start -a &
nitrogen --restore & 2>/dev/null

