/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int dwmmode  = 0;        /* laptop = 0 or tablet = 1 */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 3;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */

static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 1;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 3;       /* vertical padding of bar */
static const int sidepad            = 3;       /* horizontal padding of bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const char *fonts[]          = { dwmmode 
                                      ? "SauceCodePro Nerd Font Mono:style=Blod:pixelsize=34:type=Black:antialias=true:autohint=true"
                                      : "SauceCodePro Nerd Font Mono:style=Blod:pixelsize=18:type=Black:antialias=true:autohint=true" };
static const char col_gray1[]       = "#2d2c2c";
static const char col_gray2[]       = "#2d2c2c";//灰黑
static const char col_gray3[]       = "#e8e4e4";//灰白
static const char col_gray4[]       = "#9b8bee";//蓝紫
static const char col_cyan[]        = "#005577";//蓝色

// dwm6.3 update
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray3, col_gray4, col_gray4  },
};

/* tagging */
static const char *tags[] = { "", "", "", "󰭻", "󰎆", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance           title            tags mask   isfloating   monitor */
	{ "Gimp",           NULL,              NULL,                0,          1,          -1 },
	{ "Alacritty",      "Alacritty",       NULL,                0,          0,          -1 },
	{ "firefox",        NULL,              NULL,                0,          0,          -1 },
	{ "Alacritty",      "Alacritty",       "musicfox",          0,          0,          -1 },
	{ "Alacritty",      "Alacritty",       "ncmpcpp",           0,          1,          -1 },
	{ "Alacritty",      "Alacritty",       "bluetuith",         0,          1,          -1 },
	{ "wps",            "wps",             NULL,                0,          1,          -1 },
	{ "QQ",             "qq",              NULL,                0,          1,          -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int attachdirection = 0;    /* 0 default, 1 above, 2 aside, 3 below, 4 bottom, 5 top */
static const int newclientathead    = 0;        /* 定义默认平铺布局新窗口在栈顶还是栈底 */

/* overview */
static const int overviewgappi           = 24;        /* overview时 窗口与边缘 缝隙大小 */
static const int overviewgappo           = 60;        /* overview时 窗口与窗口 缝隙大小 */
static const char *overviewtag = "OVERVIEW";
static const Layout overviewlayout = { "",  overview };


static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "󰈺",      NULL },    /* no layout function means floating behavior */
	{ "",      monocle },
  { "󰃇",      magicgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "dwmblocks"

/* commands */
static const char *termcmd[]  = { "alacritty", NULL };
/*rofi配置*/
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
/*alacritty小窗口*/
static const char scratchpadname[] = "alacritty small window";
static const char *scratchpadcmd[] = { "alacritty", "-t" ,scratchpadname, NULL };
/*其它小窗口*/
static const char *bluetuithcmd[] = {"alacritty", "-t", "bluetuith", "-e", "bluetuith", NULL };
static const char *musiccmd[] = {"alacritty", "-t", "ncmpcpp", "-e", "ncmpcpp", NULL };
static const char *musicfoxcmd[] = {"alacritty", "-t", "musicfox", "-e", "musicfox", NULL };
/*锁屏*/
static const char *slockcmd[] = { "/home/orange/Dwm/Scripts/system/i3lock.sh", NULL };
static const char *forceoffandclockcmd[] = { "/home/orange/Dwm/Scripts/system/forceoff_lock.sh", NULL };
/*触摸板*/
static const char *touchpadcmd[] = { "/home/orange/Dwm/Scripts/system/touchpad.sh", NULL };
/*休眠*/
static const char *hibernatecmd[] = { "systemctl", "hibernate", NULL };
/*关机*/
static const char *poweroffcmd[]  = { "poweroff", NULL };
/*重启*/
static const char *rebootcmd[]  = { "reboot", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,	                      XK_Return, spawn,          {.v = termcmd } },
	/*脚本按键绑定*/
	/*Super*/
  { MODKEY,                       XK_F1,     spawn,          SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; pkill -RTMIN+5 dwmblocks") },
  { MODKEY,                       XK_F2,     spawn,          SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; pkill -RTMIN+5 dwmblocks") },
  { MODKEY,                       XK_F3,     spawn,          SHCMD("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+; pkill -RTMIN+5 dwmblocks") },
	{ MODKEY,                       XK_F4,     spawn,  	       {.v = bluetuithcmd } },
  { MODKEY,                       XK_F5,     spawn,          SHCMD("light -U 5; pkill -RTMIN+4 dwmblocks") },
  { MODKEY,                       XK_F6,     spawn,          SHCMD("light -A 5; pkill -RTMIN+4 dwmblocks") },
  { MODKEY,                       XK_F7,     spawn,          {.v = slockcmd } } ,
  { MODKEY,                       XK_F8,     spawn,          {.v = musicfoxcmd } } ,
  { MODKEY,                       XK_F9,     spawn,          {.v = musiccmd } } ,
  { MODKEY,                       XK_F10,    spawn,          {.v = touchpadcmd } } ,
  { MODKEY,                       XK_F11,    spawn,          {.v = forceoffandclockcmd } } ,
	{ MODKEY,             		      XK_Escape, spawn,          SHCMD("flameshot gui; pkill -RTMIN+10 dwmblocks") }, //Esc

	/*Super+Shift*/
	{ MODKEY|ShiftMask,             XK_Escape, spawn,          {.v = hibernatecmd } }, //休眠
  { MODKEY|ShiftMask,             XK_F1,     spawn,          {.v = poweroffcmd } }, 
  { MODKEY|ShiftMask,             XK_F2,     spawn,          {.v = rebootcmd } }, 

	{ MODKEY,                       XK_v,      togglebar,      {0} },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_y,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	/*补丁*/
	{ MODKEY,                       XK_w,      togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,    	                  XK_f,      togglefullscr,  {0} },
	{ MODKEY,	                      XK_u,      rotatestack,    {.i = +1 } },
	{ MODKEY,          	            XK_i,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	{ MODKEY|ShiftMask,	            XK_k,      aspectresize,   {.i = +24} },
  { MODKEY|ShiftMask,             XK_j,      aspectresize,   {.i = -24} },
	{ MODKEY,                       XK_space,  moveplace,      {.ui = WIN_C  }},
	{ MODKEY,                       XK_Up,     moveplace,      {.ui = WIN_N  }},
	{ MODKEY,                       XK_Left,   moveplace,      {.ui = WIN_W  }},
	{ MODKEY,                       XK_Right,  moveplace,      {.ui = WIN_E  }},
	{ MODKEY,                       XK_Down,   moveplace,      {.ui = WIN_S  }},
	{ MODKEY|ShiftMask,             XK_Up,     moveplace,      {.ui = WIN_NW }},
	{ MODKEY|ShiftMask,             XK_Right,  moveplace,      {.ui = WIN_NE }},
	{ MODKEY|ShiftMask,             XK_Left,   moveplace,      {.ui = WIN_SW }},
	{ MODKEY|ShiftMask,             XK_Down,   moveplace,      {.ui = WIN_SE }},
	{ MODKEY|ControlMask,		        XK_l,	     movekeyboard_x, {.i = 20}},
	{ MODKEY|ControlMask,		        XK_h,	     movekeyboard_x, {.i = -20}},
	{ MODKEY|ControlMask,		        XK_j,	     movekeyboard_y, {.i = 20}},
	{ MODKEY|ControlMask,		        XK_k,	     movekeyboard_y, {.i = -20}},

	{MODKEY,			                  XK_x, 	   hidewin, 	   {0}},
  {MODKEY|ShiftMask, 		          XK_x, 	   restorewin, 	   {0}},
  {MODKEY, 			                  XK_z, 	   hideotherwins,  {0}},
  {MODKEY|ShiftMask, 		          XK_z, 	   restoreotherwins, {0}},

	{ MODKEY|ShiftMask,             XK_space,  zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,	                      XK_c,      killclient,     {0} },
  { MODKEY,                       XK_a,      toggleoverview, {0} },
	{ MODKEY,                       XK_b,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_b,  	   setlayout,      {0} },
	{ MODKEY|ShiftMask, 	          XK_f,  	   togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_w,      floattag,       {.ui = ~0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button1,        spawn,          {.v = dmenucmd} }, // 左键点击中间弹出rofi应用
	{ ClkWinTitle,          0,              Button2,        killclient,     {0} }, // 中键点击中间退出应用

  /* dwmblock patch*/
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },

	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            0,              Button2,        spawn,          {.v = forceoffandclockcmd } }, // 中键点击左侧图标关闭屏幕
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

 
