#! /bin/sh
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export IDENTIFIER="unicode"
export EDITOR='nvim'
# export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export WLR_NO_HARDWARE_CURSORS=1
# export WLR_RENDERER=vulkan
export LIBVA_DRI3_DISABLE=1
# export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORMTHEME=wayland;xcb
# export SDL_VIDEODRIVER=wayland
# export XDG_CURRENT_DESKTOP=dwl
# export ENABLE_VKBASALT=1
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export INPUT_METHOD=fcitx
export GLFW_IM_MODULE=ibus
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/jre/lib/ext/mysql-connector-java-5.1.9.jar:$JAVA_HOME/jre/lib/ext/c3p0-0.9.1.2.jar:$JAVA_HOME/jre/lib/ext/druid-1.2.8.jar:$JAVA_HOME/jre/lib/ext/commons-dbutils-1.7.jar:$JAVA_HOME/jre/lib/ext/dom4j-2.1.3.jar:/usr/share/tomcat8/lib/servlet-api.jar
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia
# export MOZ_USE_XINPUT2=1

picom &
flameshot &
nitrogen --restore &
# onboard &
dwmblocks &
# prime-offload
caffeine start -a &
exec dwm
# fcitx5 -d &
# exec dwl -s waybar
