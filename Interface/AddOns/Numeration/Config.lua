local n = select(2, ...)

-- window settings
n.windowsettings = {
	pos = { "BOTTOMRIGHT", nil, "BOTTOMRIGHT", -15, 25 },
	width = 270,
	maxlines = 7,
	backgroundalpha = 0,
	scrollbar = true,

	titleheight = 16,
	titlealpha = 0,
	titlefont = GetLocale() == "zhCN" and "Fonts\\ZYKai_T.ttf" or GetLocale() == "zhTW" and "Fonts\\bLEI00D.ttf" or "Fonts\\ARIALN.ttf",
	titlefontsize = 13,
	titlefontcolor = {1, .82, 0},
	buttonhighlightcolor = {1, 1, 1},

	lineheight = 16,
	linegap = 2,
	linealpha = 1,
	linetexture = "Interface\\ChatFrame\\ChatFrameBackground",
	linefont = GetLocale() == "zhCN" and "Fonts\\ZYKai_T.ttf" or GetLocale() == "zhTW" and "Fonts\\bLEI00D.ttf" or "Fonts\\ARIALN.ttf",
	linefontsize = 12,
	linefontcolor = {1, 1, 1},
}

-- core settings
n.coresettings = {
	refreshinterval = 1,
	minfightlength = 15,
	combatseconds = 3,
	shortnumbers = true,
}

-- available types and their order
n.types = {
	{
		name = "伤害",
		id = "dd",
		c = {.25, .66, .35},
	},
	{
		name = "伤害目标",
		id = "dd",
		view = "Targets",
		onlyfights = true,
		c = {.25, .66, .35},
	},
	{
		name = "伤害承受: 目标",
		id = "dt",
		view = "Targets",
		onlyfights = true,
		c = {.66, .25, .25},
	},
	{
		name = "伤害承受: 技能",
		id = "dt",
		view = "Spells",
		c = {.66, .25, .25},
	},
	{
		name = "队友误伤",
		id = "ff",
		c = {.63, .58, .24},
	},
	{
		name = "治疗及吸收",
		id = "hd",
		id2 = "ga",
		c = {.25, .5, .85},
	},
--	{
--		name = "Healing Taken: Abilities",
--		id = "ht",
--		view = "Spells",
--		c = {.25, .5, .85},
--	},
--	{
--		name = "Healing",
--		id = "hd",
--		c = {.25, .5, .85},
--	},
--	{
--		name = "Guessed Absorbs",
--		id = "ga",
--		c = {.25, .5, .85},
--	},
	{
		name = "过量治疗",
		id = "oh",
		c = {.25, .5, .85},
	},
	{
		name = "驱散",
		id = "dp",
		c = {.58, .24, .63},
	},
	{
		name = "打断",
		id = "ir",
		c = {.09, .61, .55},
	},
	{
		name = "法力获取",
		id = "pg",
		c = {48/255, 113/255, 191/255},
	},
	{
		name = "死亡记录",
		id = "deathlog",
		view = "Deathlog",
		onlyfights = true,
		c = {.66, .25, .25},
	},
}
