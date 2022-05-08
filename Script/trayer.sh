#! /bin/sh

eval 'killall trayer'
if [ $? -ne 0 ]; then
	eval $(trayer --transparent true --expand false --edge top --align right --width 32 --height 18 --distance 2 --distancefrom top --SetDockType false --tint 0x00000000 --iconspacing 2 &)
fi

