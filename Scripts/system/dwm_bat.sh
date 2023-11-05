#! /bin/sh

BAT_MODE=$([[ -d /sys/class/power_supply/BAT1 ]] && echo "BAT1" || echo "BAT0")
BAT_Charge=$(cat /sys/class/power_supply/$BAT_MODE/energy_full)
BAT_Charge_Design=$(cat /sys/class/power_supply/$BAT_MODE/energy_full_design)
BAT_ISWORK=$(cat /sys/class/power_supply/$BAT_MODE/status)
BAT_COUNT=$(cat /sys/class/power_supply/$BAT_MODE/capacity)
BAT_Health=$(echo "scale=2;($BAT_Charge/$BAT_Charge_Design) * 100 " | bc 2>/dev/null)
BAT_MODE_NUM=$([[ $(acpi -b | wc -l) = 1 ]] && echo 'Battery 0: ' || echo 'Battery 1: ')
BAT_Time=$(acpi -b | grep -e "$BAT_MODE_NUM" | cut -d ',' -f 3 | awk -F ' ' '{print $1}' 2>/dev/null)
BAT_ISCHAR="$([[ "$BAT_ISWORK" = "Discharging" ]] && echo "正在放电" || echo "正在充电")"
BAT_Time_Info=$([[ "$BAT_ISWORK" = "Discharging" ]] && echo "预计"${BAT_Time}"后电量耗尽" \
  || ([[ "$BAT_ISWORK" = "Full" ]] && echo "电池已充满" || echo "预计"${BAT_Time}"后充满"))
export BAT_NUM=0

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '电池信息')" "$(printf '%s%s\n' \
    '电池状态:' $BAT_ISCHAR)""$(printf '\n%s%s\n' '电池健康度:' $(printf '%.0f%s' \
    ${BAT_Health} %))""$(printf '\n%s\n' ${BAT_Time_Info})";;
	2) notify-send "bat2" ;;
	4) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

#电池定义
if [[ $BAT_NUM == 0 || ( $BAT_COUNT -lt $BAT_NUM && "$BAT_ISWORK" = "Discharging" ) ]]; then
	BAT_NUM=$BAT_COUNT
elif [[ $BAT_COUNT -gt $BAT_NUM && ( "$BAT_ISWORK" = "Charging" || "$BAT_ISWORK" = "Not charging" ) ]]; then
	BAT_NUM=$BAT_COUNT
fi
case $BAT_NUM in
        10|[0-9])  BAT_ICON="󰠑" ;;
    2[0-5]|1[1-9]) BAT_ICON="󰂆" ;;
    3[0-9]|2[6-9]) BAT_ICON="󰂈" ;;
    5[0-5]|4[0-9]) BAT_ICON="󰢝" ;;
    6[0-9]|5[6-9]) BAT_ICON="󰂉" ;;
    8[0-5]|7[0-9]) BAT_ICON="󰢞" ;;
    9[0-5]|8[6-9]) BAT_ICON="󰂊" ;;
       100|9[6-9]) BAT_ICON="󰂅" ;;
esac
BAT_STATUS="$BAT_ICON:$BAT_NUM%"

##低电量提示
if [[ $BAT_COUNT -lt 15 && "$BAT_ISWORK" = "Discharging" ]]; then
		notify-send "电池电量已不足！剩余电量$BAT_COUNT%"
fi

printf "%s\n" "${BAT_STATUS}"
