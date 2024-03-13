#! /bin/sh

killall trayer 2>/dev/null
if [ $? -ne 0 ]; then
  	trayer --transparent true --expand true --edge top --align center --margin 5 --padding 5 --width 5 --height 20 --distance 3 \
      --distancefrom top --SetDockType false --tint 0x00000000 --iconspacing 2 &
fi

