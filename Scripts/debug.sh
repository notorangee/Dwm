#! /bin/sh

/usr/bin/Xephyr -screen 800x600 -br -ac -noreset :2 &
export DISPLAY=:2
sudo -E gdb $HOME/Dwm/dwm

