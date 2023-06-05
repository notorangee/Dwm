#! /bin/sh
#dwm启动执行
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export IDENTIFIER="unicode"
export EDITOR='nvim'
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export _JAVA_AWT_WM_NONREPARENTING=1
#Java 开发环境
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/jre/lib/ext/mysql-connector-java-5.1.9.jar:$JAVA_HOME/jre/lib/ext/c3p0-0.9.1.2.jar:$JAVA_HOME/jre/lib/ext/druid-1.2.8.jar:$JAVA_HOME/jre/lib/ext/commons-dbutils-1.7.jar:$JAVA_HOME/jre/lib/ext/dom4j-2.1.3.jar:/usr/share/tomcat8/lib/servlet-api.jar
# Nvdia 解码驱动
export LIBVA_DRIVER_NAME=vdpau

xrandr --auto 2>/dev/null
xset r rate 300 30 2>/dev/null
# xrandr --setprovideroutputsource modesetting NVIDIA-0 2>/dev/null
# OpenGL renderer string: AMD Radeon Graphics (renoir, LLVM 15.0.7, DRM 3.52, 6.3.5-zen1-1-zen)
prime-offload 2>/dev/null
picom --experimental-backends -b & 2>/dev/null
# killall fcitx5 2>/dev/null
# fcitx5 -d & 2>/dev/null
flameshot & 2>/dev/null
pulseaudio --start 2>/dev/null
caffeine start -a & 2>/dev/null
nitrogen --restore & 2>/dev/null
pos & 2>/dev/null
dwmblocks &
# start dwm
while true; do
  dwm 2> ~/.dwm/dwm.log
done
