local addon, ns=...
ns.config={
---------------------------------------------------------------------------------
-- use ["option"] = true/false, to set options.
-- options
-- blizz damage options.
	["blizzheadnumbers"] = true,	-- 使用blz样式在头上输出战斗信息
	["damagestyle"] = true,		-- 改变默认的战斗信息样式。需要重启wow才能看到效果,不过我感觉好像只是加了个shadow……
-- xCT outgoing damage/healing options
	["damage"] = true,		-- 显示伤害
	["healing"] = true,		-- 显示治疗
	["showhots"] = true,		-- 显示持续治疗
	["damagecolor"] = true,		-- 按伤害类型染色
	["critprefix"] = "|cffFF0000 |r",	-- 暴击前修正
	["critpostfix"] = "|cffFF0000!|r",	-- 暴击后修正，默认值为红色
	["incomecritprefix"] = "|cffFF0000*|r", -- 承受暴击前修正，默认值为红色"*"
	["incomecritpostfix"] = "|cffFF0000*|r", -- 承受暴击后修正
	["icons"] = true,		-- 显示伤害图标
	["iconsize"] = 22,		-- 图标大小，可为数值或"auto"
	["petdamage"] = true,		-- 显示宠物伤害
	["dotdamage"] = true,		-- 显示持续伤害
	["treshold"] = 1,		-- 伤害显示下限
	["healtreshold"] = 1,		-- 治疗显示下限

-- appearence
	["font"] = "Fonts\\FRIZQT__.TTF",	-- xCT输出字体，国服默认伤害字体为"Fonts\\Zykai_C.TTF"
	["fontsize"] = 18,					-- 字体大小
	["fontstyle"] = "OUTLINE",	-- 文字描边，可选值为"OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = "Fonts\\FRIZQT__.TTF",	 -- 修改blz战斗信息字体
	["damagefontsize"] = 15,	-- xCT伤害字体大小，可为数值或"auto"
	["critfix"] = 7,
	["timevisible"] = 3, 		-- 自动消失时间，原作者推荐设为3
	["scrollable"] = false,		-- 允许使用滚轮滚动
	["maxlines"] = 64,		-- 最大信息行数，行越多占内存越大

-- justify messages in frames, valid values are "RIGHT" "LEFT" "CENTER" 对齐方式，"RIGHT" "LEFT" "CENTER"分别为右对齐、左对齐、居中
	["justify_1"] = "LEFT",		-- 承受伤害的对齐方式
	["justify_2"] = "RIGHT",	-- 承受治疗的对齐方式
	["justify_3"] = "CENTER",	-- 浮动信息（比如怒气、法力、光环、连击点）的对齐方式
	["justify_4"] = "RIGHT",	-- 输出伤害和治疗的对齐方式
	["justify_5"] = "LEFT",		-- 输出暴击的对齐方式

-- class modules and goodies
	["stopvespam"] = false,		-- 暗牧进入暗影形态后自动关闭治疗输出...这玩意有效果吗?
	["dkrunes"] = true,		-- 显示dk符文恢复
	["mergeaoespam"] = true,	-- 合并AOE
	["mergeaoespamtime"] = 0.1,	-- 合并AOE时间限制，最小值为0.1
	["killingblow"] = true,		-- 在浮动信息窗口输出"你杀死了谁"，需要["damage"] = true才能工作
	["dispel"] = true,		-- 在浮动信息窗口输出"你驱散了啥"，需要["damage"] = true才能工作
	["interrupt"] = true,		-- 在浮动信息窗口输出"你打断了啥"，需要["damage"] = true才能工作
}