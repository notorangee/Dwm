#! /bin/bash

#DWM
xset r rate 300 30
/home/orange/Dwm/Scripts/system/touchpad.sh
feh --bg-fill ~/Pictures/Wallpaper/wallpaper4.jpg
picom &
flameshot &
dwmblocks &
caffeine start -a &

#DWL
#dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY
#systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY
#systemctl --user restart xdg-desktop-portal-wlr
#systemctl --user restart xdg-desktop-portal
#fcitx5 -d &
#dunst &
#waybar &
#wbg -s $HOME/Pictures/Wallpaper/wallpaper4.jpg &

#Common
alacritty -t "Alacritty - AutoStart" &
google-chrome-stable &
