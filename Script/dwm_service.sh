#! /bin/sh
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export IDENTIFIER="unicode"
setxkbmap us
nitrogen --restore
pulseaudio &
pulseaudio -k
pulseaudio --start
prime-offload
picom &
flameshot &
optimus-manager-qt &
fcitx5 &
#exec dwm
