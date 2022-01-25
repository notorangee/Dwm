#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
setxkbmap us
nitrogen --restore
pulseaudio &
pulseaudio -k
pulseaudio --start
picom &
flameshot &
optimus-manager-qt &
fcitx5 &

/* 状态栏脚本定义 */
while true; do
	sleep 1s
        /* KERNEL=$( uname -r | awk -F "-" '{print $1}' ) */
        #WIFI定义
        WIFI_ICON=''
        NO_WIFI_ICON='睊'
        WIFI_STATUS='睊'
        percentage="0%"
        WIFI_STRENGTH="0%"
        if [ $( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' ) = "wlan0" ] 
	then
		percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'| xargs)"
		if [ !$percentage ]
		then
			WIFI_STATUS=$WIFI_ICON
			WIFI_STRENGTH="$percentage%"
		else 
			WIFI_STATUS=$NO_WIFI_ICON
			WIFI_STRENGTH="0%"
		fi
	else 
		WIFI_STATUS=$NO_WIFI_ICON
		WIFI_STRENGTH="0%"
	fi
	#蓝牙定义	
	BLUE_DEVICE=$( bluetoothctl info | awk '/Alias/ {print $2}' )
        BLUE_STATUS=""

	if [ $BLUE_DEVICE ]
	then
		BLUE_STATUS=""
	else
		BLUE_DEVICE="NO_DEVICE"
	fi
	#电池定义
	BAT_COUNT=$(acpi -b | awk '{ print $4 }' | awk -F '%' '{print $1}')
	BAT="$BAT_COUNT%"
	case $BAT_COUNT in
		    10|[0-9])  BAT_STATUS="ﴏ" ;;
		2[0-5]|1[1-9]) BAT_STATUS="" ;;
		3[0-9]|2[6-9]) BAT_STATUS="" ;;
		5[0-5]|4[0-9]) BAT_STATUS="" ;;
		6[0-9]|5[6-9]) BAT_STATUS="" ;;
		8[0-5]|7[0-9]) BAT_STATUS="" ;;
		9[0-5]|8[6-9]) BAT_STATUS="" ;;
		   100|9[6-9]) BAT_STATUS="" ;;
	esac
	#状态栏定义
	if [ $BAT_COUNT -lt 10 ]
	then
		xsetroot -name "设备电量不足10%"
		sleep 1s
	fi
        LOCALTIME=$( date +'%F %A %T' )
        BACKLIGHT_INFO=`echo "scale=2; ($( cat /sys/class/backlight/amdgpu_bl0/actual_brightness ) / 255) * 100" | bc`
        BACKLIGHT="${BACKLIGHT_INFO%.*}%"
        VOL=$( amixer get Master | awk -F'[][]' 'END{ print $2 }' )
   	xsetroot -name " $BLUE_STATUS:$BLUE_DEVICE $WIFI_STATUS:$WIFI_STRENGTH ﱧ:$BACKLIGHT ﰝ:$VOL $BAT_STATUS:$BAT $LOCALTIME "
done & 


exec dwm
