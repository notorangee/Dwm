#! /bin/sh

#状态栏脚本定义 
while true; do
        sleep 1s
        #KERNEL=$( uname -r | awk -F "-" '{print $1}' )
        #WIFI定义
        WIFI_ICON=''
        NO_WIFI_ICON='睊'
	WIFI_STATUS="$NO_WIFI_ICON:0%"
        percentage="0%"
        if [ $( cat /proc/net/wireless | awk 'END{print $0}' | awk -F ':' '{print $1}' ) = "wlan0" ]
        then
                percentage="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70)}'| xargs)"
                if [ !$percentage ]
                then
			WIFI_STATUS="$WIFI_ICON:$percentage%"
                fi
        fi

        #电池定义
        BAT_COUNT=$(acpi -b | awk '{ print $4 }' | awk -F '%' '{print $1}')
        case $BAT_COUNT in
                    10|[0-9])  BAT_ICON="ﴏ" ;;
                2[0-5]|1[1-9]) BAT_ICON="" ;;
                3[0-9]|2[6-9]) BAT_ICON="" ;;
                5[0-5]|4[0-9]) BAT_ICON="" ;;
                6[0-9]|5[6-9]) BAT_ICON="" ;;
                8[0-5]|7[0-9]) BAT_ICON="" ;;
                9[0-5]|8[6-9]) BAT_ICON="" ;;
                   100|9[6-9]) BAT_ICON="" ;;
        esac
	BAT_STATUS="$BAT_ICON:$BAT_COUNT%"

	#蓝牙定义
        BLUE_DEVICE=$( bluetoothctl info | awk '/Alias/ {print $2}' )
        BLUE_STATUS=""

        if [ $BLUE_DEVICE ]
        then
                BLUE_STATUS=":$BLUE_DEVICE"
        else
        	BLUE_STATUS=":NDC"
        fi

        #状态栏定义
        if [ $BAT_COUNT -lt 10 ]
        then
                xsetroot -name "设备电量不足10%"
                sleep 1s
        fi
        LOCALTIME=$( date +'%F %A %T' )
        BACKLIGHT_INFO=`echo "scale=2; ($( cat /sys/class/backlight/amdgpu_bl0/actual_brightness ) / 255) * 100" | bc`
        BACKLIGHT="ﱧ:${BACKLIGHT_INFO%.*}%"
        VOL=$( amixer get Master | awk -F'[][]' 'END{ print $2 }' )
	VOL_STATUS="ﰝ:$VOL"
        xsetroot -name " $BLUE_STATUS $WIFI_STATUS $BACKLIGHT $VOL_STATUS $BAT_STATUS $LOCALTIME "

done &

