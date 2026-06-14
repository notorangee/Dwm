#蓝牙定义
declare -A DEVICE_DATA

eval "$(busctl call org.bluez / org.freedesktop.DBus.ObjectManager GetManagedObjects --json=short 2>/dev/null | awk '
  BEGIN {
      RS="\"/org/bluez/hci[0-9]+/dev_"
  }
  NR > 1 {
      match($0, /^[0-9A-F_]{17}/)
      mac = substr($0, RSTART, RLENGTH)
      gsub(/_/, ":", mac)

      if (length(mac) != 17) next;

      connected = "false"
      if (match($0, /"Connected":\{"type":"b","data":true\}/)) {
          connected = "true"
      }

      alias_name = "未知设备"
      if (match($0, /"Alias":\{"type":"s","data":"[^"]+/)) {
          idx = index(substr($0, RSTART), "data\":\"")
          if (idx > 0) {
              remain = substr($0, RSTART + idx + 6)
              end_idx = index(remain, "\"")
              alias_name = substr(remain, 1, end_idx - 1)
          }
      }

      battery = "N/A"
      if (match($0, /"Percentage":\{"type":"y","data":[0-9]+/)) {
          idx = index(substr($0, RSTART), "data\":")
          if (idx > 0) {
              remain = substr($0, RSTART + idx + 4)
              match(remain, /[0-9]+/)
              battery = substr(remain, RSTART, RLENGTH) "%"
          }
      }

      paired = "false"
      if (match($0, /"Paired":\{"type":"b","data":true\}/)) {
          paired = "true"
      }

      trusted = "false"
      if (match($0, /"Trusted":\{"type":"b","data":true\}/)) {
          trusted = "true"
      }

      if (connected == "true" || !seen[mac]) {
          seen[mac] = 1
          d_data[mac] = alias_name "|" connected "|" battery "|" paired "|" trusted
      }

  }
  END {
      for (mac in d_data) {
        printf "DEVICE_DATA[\"%s\"]=\"%s\";\n", mac, d_data[mac]
      }
  }'
)"
BLUE_ICON="󰂲"
BLUE_STATUS="NDC"

function BLUE_CHECK {
  for DEV_MAC in ${!DEVICE_DATA[@]}; do
    DEV_DATA=${DEVICE_DATA[$DEV_MAC]}
    IFS='|' read -r DEV_NAME DEV_ONLINE DEV_BATTERY DEV_PAIRED DEV_TRUSTED <<< "$DEV_DATA"
    DEV_NAME=$(echo "$DEV_NAME" | xargs)
    DEV_ONLINE=$(echo "$DEV_ONLINE" | xargs)
    DEV_BATTERY=$(echo "$DEV_BATTERY" | xargs)
    DEV_PAIRED=$(echo "$DEV_PAIRED" | xargs)
    DEV_TRUSTED=$(echo "$DEV_TRUSTED" | xargs)

    if [[ "$DEV_ONLINE" = "true" ]]; then
      BLUE_ICON="󰂱"
      BLUE_STATUS="CTD"
      if [[ "$DEV_NAME" = "Keyboard K380" ]]; then
        xset r rate 300 30 2>/dev/null #设置蓝牙键盘在唤醒时的响应速度
      fi
      if [[ $BLOCK_BUTTON == 1 ]]; then
        printf "%s\n%s\n%s\n%s\n%s\n%s\n\n" "设备名称:$DEV_NAME" \
          "MAC地址:$DEV_MAC" "连接状态:$DEV_ONLINE" "电池电量:$DEV_BATTERY" "配对状态:$DEV_PAIRED" \
          "信任设备:$DEV_TRUSTED"
      fi
    fi
  done
  if [[ "$BLUE_STATUS" = "NDC" && $BLOCK_BUTTON == 1 ]]; then
    printf "%s\n" "无设备连接"
  fi
}

case $BLOCK_BUTTON in
  1) notify-send "$(printf '%s\n' '蓝牙设备')" "$(BLUE_CHECK)" ;;
	3) alacritty -t "bluetuith" -e "bluetuith" ;;
	6) alacritty -e $EDITOR "$0" ;;
esac

if [[ $BLOCK_BUTTON -eq 1 ]]; then
  BLOCK_BUTTON=0
fi

BLUE_CHECK

printf "%s\n" "${BLUE_ICON}:${BLUE_STATUS}"
