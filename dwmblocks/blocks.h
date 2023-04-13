//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "~/Dwm/Scripts/user/flameshot.sh",		      0,		10},
	{"", "~/Dwm/Scripts/user/note.sh",		          0,		9},
	{"", "~/Dwm/Scripts/user/trayer.sh",		        0,		8},
	{"", "~/Dwm/Scripts/system/dwm_blue.sh",		    2,		7},
	{"", "~/Dwm/Scripts/system/dwm_wifi.sh",		    30,		6},
	{"", "~/Dwm/Scripts/system/dwm_vol.sh",		      5,		5},
	{"", "~/Dwm/Scripts/system/dwm_backlight.sh",		0,		4},
	{"", "~/Dwm/Scripts/system/dwm_bat.sh",		      30,		3},
	{"", "~/Dwm/Scripts/system/dwm_fcitx.sh",	      5,		2},
	{"", "~/Dwm/Scripts/system/dwm_clock.sh",	      5,		1},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
