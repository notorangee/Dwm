#! /bin/sh
#dwm启动执行
xrandr --auto
xset r rate 300 30
xrandr --setprovideroutputsource modesetting NVIDIA-0
prime-offload &
picom --experimental-backends -b & 2>/dev/null
killall fcitx5 2>/dev/null
fcitx5 -d & 2>/dev/null
flameshot & 2>/dev/null
caffeine start -a & 2>/dev/null
nitrogen --restore & 2>/dev/null

