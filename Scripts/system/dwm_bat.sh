#! /bin/sh

BAT_Charge=$(cat /sys/class/power_supply/BAT1/charge_full)
BAT_Charge_Design=$(cat /sys/class/power_supply/BAT1/charge_full_design)
BAT_ISWORK=$(cat /sys/class/power_supply/BAT1/status)
BAT_COUNT=$(cat /sys/class/power_supply/BAT1/capacity)
BAT_Health=$(echo "scale=2;($BAT_Charge/$BAT_Charge_Design) * 100 " | bc)
BAT_ISCHAR=$([[ "$BAT_ISWORK" = "Discharging" ]] && echo "未充电" || echo "正在充电")

case $BUTTON in
  1) notify-send "$(printf '\t\t\t%s\n' '电池信息')" "$(printf '\t\t\t    %s\t%s\n' '状态:' $BAT_ISCHAR)""
    $(printf '\t\t\t    %s\t%s\n' '健康度:' $(printf '\t%d%s\n' ${BAT_Health} % 2>/dev/null))" ;;
	2) notify-send "bat2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#变量初始化
export NotifyCount=0
export BAT_NUM=0


#电池定义
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

printf "%s\n" "${BAT_STATUS}"
