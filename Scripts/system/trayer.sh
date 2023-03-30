#! /bin/sh

killall trayer 2>/dev/null
if [ $? -ne 0 ]; then
  	trayer --transparent true --expand false --edge top --align center --width 32 --height 25 --distance 2 \
      --distancefrom top --SetDockType false --tint 0x00000000 --iconspacing 10 &
fi

