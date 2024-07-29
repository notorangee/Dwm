#! /bin/sh
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export IDENTIFIER="unicode"
export EDITOR='nvim'
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
export LIBVA_DRIVER_NAME=radeonsi
# export LIBVA_DRI3_DISABLE=1
# export MOZ_USE_XINPUT2=1

picom --experimental-backends &
flameshot &
pulseaudio --start
nitrogen --restore &
onboard &
dwmblocks &
prime-offload
exec dwm
