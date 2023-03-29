#!/bin/sh
# Utility functions for theming statusbar scripts.

display() {
    if [ -n "$2" ]; then
        color="$2"
    else
        case "$(basename "$0")" in
            dwm_blue) color=13 ;;
            dwm_wifi) color=14 ;;
            dwm_vol) color=10 ;;
            dwm_bat) color=15 ;;
            dwm_fcitx) color=11 ;;
            dwm_clock) color=9 ;;
            *) color=15 ;;
        esac
    fi

    case "$STATUSBAR" in
        "dwmblocks")
            echo "^C$color^$1"
            ;;
        *)
            echo "$1"
            ;;
    esac
}

