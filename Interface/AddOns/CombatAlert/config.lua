local _, ns = ...
--如需要显示中文，请注意文件编码格式UTF-8
ns.setting = {
	EnableExecute = true,
	ShowExecuteForBossOnly = true,
	AutoThreshold = true,
	ExecuteThreshold = 0.2,
}

ns.texts = {
	EnterCombat = {
		"进入战斗！",
		},
	LeaveCombat = {
		"脱离战斗！",
		},
	ExecutePhase = {
		"斩杀！",
		},
}

ns.class = {
	["WARRIOR"] = { 0.2, 0.2, 0},
	["DRUID"] = { 0, 0.25, 0.25},
	["PALADIN"] = { 0, 0, 0.2},
	["PRIEST"] = { 0, 0, 0.25},
	["DEATHKNIGHT"] = { 0, 0.35, 0},
	["WARLOCK"] = { 0.25, 0.25, 0.25},
	["ROGUE"] = { 0.35, 0, 0},
	["HUNTER"] = { 0.2, 0.2, 0.2},
	["MAGE"] = { 0, 0.35, 0},
	["SHAMAN"] = { 0, 0, 0},	
}