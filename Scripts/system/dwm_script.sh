#! /bin/sh

#变量初始化
NotifyCount=0
BAT_NUM=0

#状态栏脚本定义 
while true; do

	#WIFI定义
	WIFI_ICON=''
	NO_WIFI_ICON='睊'
	WIFI_STATUS="$NO_WIFI_ICON:0%"
	percentage="0%"
	if [ $( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' ) = "wlan0" ]; then
	        percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'| xargs | awk '{print $1 }')"
	        if [ !$percentage ]
	        then
			WIFI_STATUS="$WIFI_ICON:$percentage%"
	        fi
  fi
	
	#电池定义
	BAT_ISWORK=$(cat /sys/class/power_supply/BAT1/status)
	BAT_COUNT=$(acpi -b | grep "0:" | cut -d ',' -f 2 | sed 's/[[:space:]]//g' | cut -d% -f1)
  if [[ $BAT_NUM == 0 || ( $BAT_COUNT -lt $BAT_NUM && "$BAT_ISWORK" = "Discharging" ) ]]; then
		BAT_NUM=$BAT_COUNT
	elif [[ $BAT_COUNT -gt $BAT_NUM && ( "$BAT_ISWORK" = "Charging" || "$BAT_ISWORK" = "Not charging" ) ]]; then
		BAT_NUM=$BAT_COUNT
	fi
	case $BAT_NUM in
	            10|[0-9])  BAT_ICON="ﴏ" ;;
	        2[0-5]|1[1-9]) BAT_ICON="" ;;
	        3[0-9]|2[6-9]) BAT_ICON="" ;;
	        5[0-5]|4[0-9]) BAT_ICON="" ;;
	        6[0-9]|5[6-9]) BAT_ICON="" ;;
	        8[0-5]|7[0-9]) BAT_ICON="" ;;
	        9[0-5]|8[6-9]) BAT_ICON="" ;;
	           100|9[6-9]) BAT_ICON="" ;;
	esac
	BAT_STATUS="$BAT_ICON:$BAT_NUM%"
	##低电量提示
	if [[ $BAT_COUNT -lt 15 && "$BAT_ISWORK" = "Discharging" ]]; then
	        xsetroot -name "设备电量不足15%"
		NotifyCount=$((${NotifyCount} + 1))
		if [ $NotifyCount -eq 10 ]; then
			notify-send "电池电量已不足！剩余电量$BAT_COUNT%"
			NotifyCount=0
		fi
		sleep 1s
	fi
	
	#蓝牙定义
	BLUE_DEVICE1=$( bluetoothctl info | awk '/Alias/' | awk -F ' ' '{print $2}' )
	BLUE_STATUS=""
	
	if [ $BLUE_DEVICE1 ]; then
	        BLUE_STATUS=":$BLUE_DEVICE1"
	else
		BLUE_STATUS=":NDC"
	fi
	
	#音量定义
	VOL_SWITCH=$( pulseaudio-ctl full-status | awk -F " " '{print $2}' )
	if [ "$VOL_SWITCH" = "no" ];then
		VOL=$( pulseaudio-ctl full-status | awk -F " " '{print $1}' )
	else
		VOL="xx%"
	fi
	VOL_STATUS="ﰝ:$VOL%"

	#背光定义
	BACKLIGHT_INFO=`echo "scale=1; ($( cat /sys/class/backlight/intel_backlight/brightness ) / 15) * 1" | bc`
	BACKLIGHT="ﱧ:${BACKLIGHT_INFO%.*}%"

	#时间定义
	LOCALTIME=$( date +'%F %A %H:%M' )

	#输入法状态
	INPUT_READ=$( fcitx5-remote )
	INPUT_STATUS="英"
	if [ $INPUT_READ -eq 2 ]; then
		INPUT_STATUS="中"
	fi
	
	#状态栏样式定义
	xsetroot -name " $BLUE_STATUS $WIFI_STATUS $VOL_STATUS $BACKLIGHT $BAT_STATUS $INPUT_STATUS $LOCALTIME " 2>/dev/null
	if [ $? -ne 0 ]; then
		break;
	fi

	sleep 1s
done

