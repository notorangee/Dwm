/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 3;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const char *fonts[]          = { "SauceCodePro Nerd Font Mono:pixelsize=24:type=Black:antialias=true:autohint=true" };
static const char col_gray1[]       = "#2d2c2c";
static const char col_gray2[]       = "#2d2c2c";//灰黑
static const char col_gray3[]       = "#e8e4e4";//灰白
static const char col_gray4[]       = "#9b8bee";//蓝紫
static const char col_cyan[]        = "#005577";//蓝色

//alpha补丁
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray3, col_gray4, col_gray4  },
};

//alpha补丁
static const unsigned int alphas[][3]      = {
       /*               fg      bg        border     */
       [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
       [SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "", "", "", "ﮠ", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int attachdirection = 5;    /* 0 default, 1 above, 2 aside, 3 below, 4 bottom, 5 top */


static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "",      NULL },    /* no layout function means floating behavior */
	{ "",      monocle },
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
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *termcmd[]  = { "alacritty", NULL };
/*rofi配置*/
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *notecmd[] = { "xournalpp", NULL };
/*alacritty小窗口*/
static const char scratchpadname[] = "alacritty small window";
static const char *scratchpadcmd[] = { "alacritty", "-t" ,scratchpadname, NULL };
/*Bluetuith小窗口*/
static const char *bluetuithcmd[] = {"alacritty", "-e", "bluetuith", NULL };
static const char *musiccmd[] = {"alacritty", "-e", "ncmpcpp", NULL };
/*flameshot截图*/
static const char *flameshot[]   = {"flameshot", "gui", NULL };
/*屏幕亮度调节*/
static const char *backlightUp[] = { "xbacklight", "-inc", "5", NULL };
static const char *backlightDown[] = { "xbacklight", "-dec", "5", NULL };
/*系统音量调节*/
static const char *soundUp[] = { "pulseaudio-ctl", "up", NULL };
static const char *soundDown[] = { "pulseaudio-ctl", "down", NULL };
static const char *soundToggle[] = { "pulseaudio-ctl", "mute", NULL };
/*托盘开启关闭脚本*/
static const char *trayer[] = { "/home/orange/Dwm/Scripts/trayer.sh", NULL };
/*熄屏*/
static const char *forceoffcmd[] = { "/home/orange/Dwm/Scripts/forceoff.sh", NULL };
/*锁屏*/
static const char *slockcmd[] = { "/home/orange/Dwm/Scripts/i3lock.sh", NULL };
static const char *forceoffandclockcmd[] = { "/home/orange/Dwm/Scripts/forceoff_lock.sh", NULL };
/*关机*/
static const char *poweroffcmd[]  = { "poweroff", NULL };
/*重启*/
static const char *rebootcmd[]  = { "reboot", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,	                      XK_Return, spawn,          {.v = termcmd } },
	/*脚本按键绑定*/
	/*Super*/
	{ MODKEY,                       XK_F1,     spawn,          {.v = soundToggle } },
        { MODKEY,                 XK_F2,     spawn,          {.v = soundDown } },
        { MODKEY,                 XK_F3,     spawn,          {.v = soundUp } },
	{ MODKEY,                       XK_F4,     spawn,  	   {.v = bluetuithcmd } },
        { MODKEY,                 XK_F5,     spawn,          {.v = backlightDown } },
        { MODKEY,                 XK_F6,     spawn,          {.v = backlightUp } },
        { MODKEY,                 XK_F7,     spawn,          {.v = slockcmd } } ,
        { MODKEY,                 XK_F8,     spawn,          {.v = trayer } } ,
        { MODKEY,                 XK_F9,     spawn,          {.v = musiccmd } } ,
        { MODKEY,                 XK_F10,    spawn,          {.v = forceoffcmd } } ,
	      { MODKEY,             		XK_Escape, spawn,          {.v = flameshot } }, //Esc
											
	/*Super+Shift*/
        { MODKEY|ShiftMask,       XK_F1,     spawn,          {.v = poweroffcmd } }, 
        { MODKEY|ShiftMask,       XK_F2,     spawn,          {.v = rebootcmd } }, 

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
        { MODKEY|ShiftMask,       XK_j,      aspectresize,   {.i = -24} },
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
   	{MODKEY|ShiftMask, 		        XK_x, 	   restorewin, 	   {0}},
   	{MODKEY, 			                XK_z, 	   hideotherwins,  {0}},
   	{MODKEY|ShiftMask, 		        XK_z, 	   restoreotherwins, {0}},

	{ MODKEY|ShiftMask,             XK_space,  zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,	                      XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_b,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_b,  	   setlayout,      {0} },
	{ MODKEY|ShiftMask, 	          XK_f,  	   togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
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
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        spawn,          {.v = notecmd} }, // 左键点击中间弹出笔记应用
	{ ClkWinTitle,          0,              Button2,        killclient,     {0} }, // 中键点击中间退出应用
	// { ClkStatusText,        0,              Button1,        spawn,          {.v = dmenucmd} }, //左键点击右边弹出rofi
	// { ClkStatusText,        0,              Button2,        spawn,          {.v = flameshot} },

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

 
