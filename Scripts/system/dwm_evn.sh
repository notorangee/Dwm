#! /bin/sh
#dwm启动执行
xrandr --auto 2>/dev/null
xset r rate 300 30 2>/dev/null
xrandr --setprovideroutputsource modesetting NVIDIA-0 2>/dev/null
prime-offload & 2>/dev/null
picom --experimental-backends -b & 2>/dev/null
killall fcitx5 2>/dev/null
fcitx5 -d & 2>/dev/null
flameshot & 2>/dev/null
caffeine start -a & 2>/dev/null
nitrogen --restore & 2>/dev/null
pos & 2>/dev/null
