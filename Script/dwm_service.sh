#! /bin/sh

nitrogen --restore
pulseaudio &
pulseaudio -k
pulseaudio --start
picom &
flameshot &
optimus-manager-qt &
fcitx5 &
