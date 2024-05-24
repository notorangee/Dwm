#! /bin/sh
Touchpad="$(xinput list | grep -P '(?<= )[\w\s:]*(?i)(touchpad|synaptics)(?-i).*?(?=\s*id)' -o | head -n1)"
TouchpadStatus="$(xinput list 'MSFT0001:00 04F3:3186 Touchpad' | grep 'This device is' | cut -d ' ' -f 4)"
[[ "${TouchpadStatus}" = "disabled" ]] && (/usr/bin/xinput enable "${Touchpad}" && notify-send -t 1500 "Touchpad Enabled") \
  || (/usr/bin/xinput disable "${Touchpad}" && notify-send -t 1500 "Touchpad Disabled")
