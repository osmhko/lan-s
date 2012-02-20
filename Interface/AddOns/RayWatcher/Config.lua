﻿-----------------------------------------------------------------------------------------------------
-- name = "目标debuff",
-- setpoint = { "BOTTOMRIGHT", UI_Parent, "CENTER", 300, -152 },
-- direction = "UP",
-- iconSide = "LEFT",
-- mode = "BAR", 
-- size = 24,
-- barWidth = 170,				
--	{spellID = 8050, unitId = "target", caster = "target", filter = "DEBUFF"},
--	{ spellID = 18499, filter = "CD" },
--	{ itemID = 56285, filter = "itemCD" },
---------------------------------------------------------------------------------------------------
--local R, C = unpack(RayUI)
local _, ns = ...

ns.font = "Interface\\Addons\\RayWatcher\\Media\\pxFont.ttf"
ns.fontsize = 12
ns.fontflag = "OUTLINE"

ns.watchers ={
	["DRUID"] = {
		{
			name = "玩家buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 80 },
			size = 28,

			-- 生命之花
			{ spellID = 33763, unitId = "player", caster = "player", filter = "BUFF" },
			-- 回春術
			{ spellID = 774, unitId = "player", caster = "player", filter = "BUFF" },
			-- 癒合
			{ spellID = 8936, unitId = "player", caster = "player", filter = "BUFF" },
			-- 野性痊癒
			{ spellID = 48438, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			name = "目标buff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 80 },
			size = 28,

			-- 生命之花
			{ spellID = 33763, unitId = "target", caster = "player", filter = "BUFF" },
			-- 回春術
			{ spellID = 774, unitId = "target", caster = "player", filter = "BUFF" },
			-- 癒合
			{ spellID = 8936, unitId = "target", caster = "player", filter = "BUFF" },
			-- 野性痊癒
			{ spellID = 48438, unitId = "target", caster = "player", filter = "BUFF" },

		},
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- 蝕星蔽月(月蝕)
			{ spellID = 48518, unitId = "player", caster = "player", filter = "BUFF" },
			-- 蝕星蔽月(日蝕)
			{ spellID = 48517, unitId = "player", caster = "player", filter = "BUFF" },
			-- 流星
			{ spellID = 93400, unitId = "player", caster = "player", filter = "BUFF" },
			-- 兇蠻咆哮
			{ spellID = 52610, unitId = "player", caster = "player", filter = "BUFF" },
			-- 求生本能
			{ spellID = 61336, unitId = "player", caster = "player", filter = "BUFF" },
			-- 生命之樹
			{ spellID = 33891, unitId = "player", caster = "player", filter = "BUFF" },
			-- 節能施法
			{ spellID = 16870, unitId = "player", caster = "player", filter = "BUFF" },
			-- 啟動
			{ spellID = 29166, unitId = "player", caster = "all", filter = "BUFF" },
			-- 樹皮術
			{ spellID = 22812, unitId = "player", caster = "player", filter = "BUFF" },
			-- 狂暴
			{ spellID = 50334, unitId = "player", caster = "player", filter = "BUFF" },
			-- 狂暴恢復
			{ spellID = 22842, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 休眠
			{ spellID = 2637, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 糾纏根鬚
			{ spellID = 339, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 颶風術
			{ spellID = 33786, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 月火術
			{ spellID = 8921, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 日炎術
			{ spellID = 93402, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 蟲群
			{ spellID = 5570, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 掃擊
			{ spellID = 1822, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 撕扯
			{ spellID = 1079, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 割裂
			{ spellID = 33745, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 血襲
			{ spellID = 9007, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 割碎
			{ spellID = 33876, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 大地新月
			{ spellID = 48506, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 精靈之火(野性)
			{ spellID = 16857, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 精靈之火
			{ spellID = 770, unitId = "target", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 休眠
			{ spellID = 2637, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 糾纏根鬚
			{ spellID = 339, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 颶風術
			{ spellID = 33786, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			name = "CD",
			direction = "DOWN",
			iconSide = "LEFT",
			mode = "BAR",
			size = 28,
			barWidth = 170,
			setpoint = { "LEFT", UIParent, "LEFT", 5, -6 },

			--狂暴
			{ spellID = 50334, filter = "CD" },
			--狂暴恢復
			{ spellID = 22842, filter = "CD" },
			--狂怒
			{ spellID = 5229, filter = "CD" },
			--啟動
			{ spellID = 29166, filter = "CD" },
			--複生
			{ spellID = 20484, filter = "CD" },
			--樹皮術
			{ spellID = 22812, filter = "CD" },
			--挑戰怒吼
			{ spellID = 5209, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- 蓄勢待發
			{ spellID = 56342, unitId = "player", caster = "player", filter = "BUFF" },
			-- 快速射擊
			{ spellID = 6150, unitId = "player", caster = "player", filter = "BUFF" },
			-- 戰術大師
			{ spellID = 34837, unitId = "player", caster = "player", filter = "BUFF" },
			-- 強化穩固射擊
			{ spellID = 53224, unitId = "player", caster = "player", filter = "BUFF" },
			-- 急速射擊
			{ spellID = 3045, unitId = "player", caster = "player", filter = "BUFF" },
			-- 治療寵物
			{ spellID = 136, unitId = "pet", caster = "player", filter = "BUFF" },
			-- 狂野呼喚
			{ spellID = 53434, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 翼龍釘刺
			{ spellID = 19386, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 沉默射擊
			{ spellID = 34490, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 毒蛇釘刺
			{ spellID = 1978, unitId = "target", caster = "player", filter = "DEBUFF" },
			{ spellID = 88453, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 寡婦毒液
			{ spellID = 82654, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 黑蝕箭
			{ spellID = 3674, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 爆裂射擊
			{ spellID = 53301, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 獵人印記
			{ spellID = 1130, unitId = "target", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 翼龍釘刺
			{ spellID = 19386, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 沉默射擊
			{ spellID = 34490, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["MAGE"] = {
		{
			name = "玩家重要buff&debuff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- 冰霜之指
			{ spellID = 44544, unitId = "player", caster = "player", filter = "BUFF" },
			-- 腦部凍結
			{ spellID = 44546, unitId = "player", caster = "player", filter = "BUFF" },
			-- 焦炎之痕
			{ spellID = 48108, unitId = "player", caster = "player", filter = "BUFF" },
			-- 飛彈彈幕
			{ spellID = 79683, unitId = "player", caster = "player", filter = "BUFF" },
			-- 秘法強化
			{ spellID = 12042, unitId = "player", caster = "player", filter = "BUFF" },
			-- 節能施法
			{ spellID = 12536, unitId = "player", caster = "player", filter = "BUFF" },
			-- 衝擊
			{ spellID = 64343, unitId = "player", caster = "player", filter = "BUFF" },
			-- 秘法衝擊
			{ spellID = 36032, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- 強化法力寶石
			{ spellID = 83098, unitId = "player", caster = "player", filter = "BUFF" },
			-- 咒法轉移
			{ spellID = 44413, unitId = "player", caster = "player", filter = "BUFF" },
			-- 秘法潛能
			{ spellID = 57531, unitId = "player", caster = "player", filter = "BUFF" },
			-- 寒冰護體
			{ spellID = 11426, unitId = "player", caster = "player", filter = "BUFF" },
			-- 早霜
			{ spellID = 83049, unitId = "player", caster = "player", filter = "BUFF" },
			-- 2T13效果
			{ spellID = 105785, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 變形術
			{ spellID = 118, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 龍之吐息
			{ spellID = 31661, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 衝擊波
			{ spellID = 11113, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 深冬之寒
			{ spellID = 28593, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 減速術
			{ spellID = 31589, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 燃火
			{ spellID = 83853, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 點燃
			{ spellID = 12654, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 活體爆彈
			{ spellID = 44457, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 炎爆術!
			{ spellID = 92315, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 極度冰凍
			{ spellID = 44572, unitId = "target", caster = "player", filter = "DEBUFF"},

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 變形術
			{ spellID = 118, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 活體爆彈
			{ spellID = 44457, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			name = "CD",
			direction = "DOWN",
			iconSide = "LEFT",
			mode = "BAR",
			size = 28,
			barWidth = 170,
			setpoint = { "LEFT", UIParent, "LEFT", 5, -6 },

			
			-- 镜像术
			{ spellID = 55342, unitId = "player", caster = "player", filter = "CD" },
            -- 霜之环
			{ spellID = 82676, unitId = "player", caster = "player", filter = "CD" },
            -- 烈焰之球
			{ spellID = 82731, unitId = "player", caster = "player", filter = "CD" },
            -- 隐形术
			{ spellID = 66, unitId = "player", caster = "player", filter = "CD" },
            -- 燃火
			{ spellID = 11129, unitId = "player", caster = "player", filter = "CD" },
			-- 唤醒
			{ spellID = 12051, unitId = "player", caster = "player", filter = "CD" },
			-- 秘法強化
			{ spellID = 12042, unitId = "player", caster = "player", filter = "CD" },
			-- 急速冷卻
			{ spellID = 11958, unitId = "player", caster = "player", filter = "CD" },
			-- 極度冰凍
			{ spellID = 44572, unitId = "player", caster = "player", filter = "CD" },
			-- 冰寒脈動
			{ spellID = 12472, unitId = "player", caster = "player", filter = "CD" },
		},
	},
	["WARRIOR"] = {
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- Sudden Death / Plötzlicher Tod
			{ spellID = 52437, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodsurge / Schäumendes Blut
			{ spellID = 46916, unitId = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board / Schwert und Schild
			{ spellID = 50227, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Reserve / Blutreserve
			{ spellID = 64568, unitId = "player", caster = "player", filter = "BUFF" },
			-- Spell Reflection / Zauberreflexion
			{ spellID = 23920, unitId = "player", caster = "player", filter = "BUFF" },
			-- Victory Rush / Siegesrausch
			{ spellID = 34428, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Block / Schildblock
			{ spellID = 2565, unitId = "player", caster = "player", filter = "BUFF" },
			-- Last Stand / Letztes Gefecht
			{ spellID = 12975, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall / Schildwall
			{ spellID = 871, unitId = "player", caster = "player", filter = "BUFF" },
			{ spellID = 12975, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- Charge Stun / Sturmangriffsbetäubung
			{ spellID = 7922, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shockwave / Schockwelle
			{ spellID = 46968, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hamstring / Kniesehne
			{ spellID = 1715, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Rend / Verwunden
			{ spellID = 94009, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunder Armor /Rüstung zerreiße
			{ spellID = 7386, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Thunder Clap / Donnerknall
			{ spellID = 6343, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demoralizing Shout / Demoralisierender Ruf
			{ spellID = 1160, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor / Rüstung schwächen (Rogue)
			{ spellID = 8647, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds / Infizierte Wunden (Druid)
			{ spellID = 48484, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Frost Fever / Frostfieber (Death Knight)
			{ spellID = 55095, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Demoralizing Roar / Demoralisierendes Gebrüll (Druid)
			{ spellID = 99, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness / Fluch der Schwäche (Warlock)
			{ spellID = 702, unitId = "target", caster = "all", filter = "DEBUFF" },

		},
	},
	["SHAMAN"] = {
		{
			name = "玩家buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 80 },
			size = 28,
			
			-- Earth Shield / Erdschild
			{ spellID = 974, unitId = "player", caster = "player", filter = "BUFF" },
			-- Riptide / Springflut
			{ spellID = 61295, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightning Shield / Blitzschlagschild
			{ spellID = 324, unitId = "player", caster = "player", filter = "BUFF" },
			-- Water Shield / Wasserschild
			{ spellID = 52127, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标buff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 80 },
			size = 28,
			
			-- Earth Shield / Erdschild
			{ spellID = 974, unitId = "target", caster = "player", filter = "BUFF" },
			-- Riptide / Springflut
			{ spellID = 61295, unitId = "target", caster = "player", filter = "BUFF" },

		},
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- Maelstorm Weapon / Waffe des Mahlstroms
			{ spellID = 53817, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shamanistic Rage / Schamanistische Wut
			{ spellID = 30823, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting / Freizaubern
			{ spellID = 16246, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves / Flutwellen
			{ spellID = 51562, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude / Seelenstärke der Ahnen
			{ spellID = 16177, unitId = "target", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- Hex / Verhexen
			{ spellID = 51514, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Bind Elemental / Elementar binden
			{ spellID = 76780, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Storm Strike / Sturmschlag
			{ spellID = 17364, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock / Erdschock
			{ spellID = 8042, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock / Frostschock
			{ spellID = 8056, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock / Flammenschock
			{ spellID = 8050, unitId = "target", caster = "player", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- Hex / Verhexen
			{ spellID = 51514, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Bind Elemental / Elementar binden
			{ spellID = 76780, unitId = "focus", caster = "all", filter = "DEBUFF" },

		},
	},
	["PALADIN"] = {
		{
			name = "玩家buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 80 },
			size = 28,
			
			-- 聖光信標
			{ spellID = 53563, unitId = "player", caster = "player", filter = "BUFF" },
			-- 純潔審判
			{ spellID = 53657, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			name = "目标buff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 80 },
			size = 28,
			
			-- 聖光信標
			{ spellID = 53563, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,

			-- 神聖之盾
			{ spellID = 20925, unitId = "player", caster = "player", filter = "BUFF" },
			-- 神性祈求
			{ spellID = 54428, unitId = "player", caster = "player", filter = "BUFF" },
			-- 神恩術
			{ spellID = 31842, unitId = "player", caster = "player", filter = "BUFF" },
			-- 異端審問
			{ spellID = 84963, unitId = "player", caster = "player", filter = "BUFF" },
			-- 狂熱精神
			{ spellID = 85696, unitId = "player", caster = "player", filter = "BUFF" },
			-- 破曉之光
			{ spellID = 88819, unitId = "player", caster = "player", filter = "BUFF" },
			-- 聖光灌注
			{ spellID = 54149, unitId = "player", caster = "player", filter = "BUFF" },
			-- 精通光環
			{ spellID = 31821, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 制裁之錘
			{ spellID = 853, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 剛正審判
			{ spellID = 68055, unitId = "target", caster = "player", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 制裁之錘
			{ spellID = 853, unitId = "focus", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "CD",
			direction = "DOWN",
			iconSide = "LEFT",
			mode = "BAR",
			size = 28,
			barWidth = 170,
			setpoint = { "LEFT", UIParent, "LEFT", 5, -6 },--{ "TOPLEFT", RayUIActionBar3, "BOTTOMRIGHT", -27, -6 },

			--神恩術
			{ spellID = 31842, filter = "CD" },
			--復仇之怒
			{ spellID = 31884, filter = "CD" },
			--精通光環
			{ spellID = 31821, filter = "CD" },
			--聖療術
			{ spellID = 633, filter = "CD" },
			--神性祈求
			{ spellID = 54428, filter = "CD" },
			--遠古諸王守護者
			{ spellID = 86150, filter = "CD" },
			--狂熱精神
			{ spellID = 85696, filter = "CD" },
			--圣佑術
			{ spellID = 498, filter = "CD" },
		},
	},
	["PRIEST"] = {
		{
			name = "玩家buff&debuff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 80 },
			size = 28,
			
			-- 真言術：盾
			{ spellID = 17, unitId = "player", caster = "all", filter = "BUFF" },
			-- 漸隱術
			{ spellID = 586, unitId = "player", caster = "player", filter = "BUFF" },
			-- 防護恐懼結界
			{ spellID = 6346, unitId = "player", caster = "all", filter = "BUFF" },
			-- 心靈意志
			{ spellID = 73413, unitId = "player", caster = "player", filter = "BUFF" },
			-- 大天使
			{ spellID = 81700, unitId = "player", caster = "player", filter = "BUFF" },
			-- 黑天使
			{ spellID = 87153, unitId = "player", caster = "player", filter = "BUFF" },
			-- 強化暗影
			{ spellID = 95799, unitId = "player", caster = "player", filter = "BUFF" },
			--虚弱靈魂
			{ spellID = 6788, unitId = "player", caster = "all", filter = "DEBUFF" },
		},
		{
			name = "目标buff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 80 },
			size = 28,
			
			-- 愈合祷言
			{ spellID = 41635, unitId = "target", caster = "player", filter = "BUFF" },
			-- 守护之魂
			{ spellID = 47788, unitId = "target", caster = "player", filter = "BUFF" },
			-- 痛苦镇压
			{ spellID = 33206, unitId = "target", caster = "player", filter = "BUFF" },
			-- 真言术：盾
			{ spellID = 17, unitId = "target", caster = "player", filter = "BUFF" },
			-- 恢复
			{ spellID = 139, unitId = "target", caster = "player", filter = "BUFF" },
			-- 靈感
			{ spellID = 15357, unitId = "target", caster = "player", filter = "BUFF" },
			-- 恩典
			{ spellID = 77613, unitId = "target", caster = "player", filter = "BUFF" },

		},
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- 光之澎湃
			{ spellID = 88688, unitId = "player", caster = "all", filter = "BUFF" },
			-- 機緣回復
			{ spellID = 63735, unitId = "player", caster = "player", filter = "BUFF" },
			-- 暗影寶珠
			{ spellID = 77487, unitId = "player", caster = "player", filter = "BUFF" },
			-- 佈道
			{ spellID = 81661, unitId = "player", caster = "player", filter = "BUFF" },
			-- 黑暗佈道
			{ spellID = 87118, unitId = "player", caster = "player", filter = "BUFF" },
			-- 影散
			{ spellID = 47585, unitId = "player", caster = "player", filter = "BUFF" },
			--爭分奪秒
            { spellID = 59888, unitId = "player", caster = "player", filter = "BUFF" },	
            --真言術：壁
            { spellID = 81782 , unitId = "player", caster = "all", filter = "BUFF" },	
            --2T12效果
            { spellID = 99132,  unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 束縛不死生物
			{ spellID = 9484, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 心靈尖嘯
			{ spellID = 8122, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 暗言術:痛
			{ spellID = 589, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 噬靈瘟疫
			{ spellID = 2944, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 吸血之觸
			{ spellID = 34914, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 心靈融烙
			{ spellID = 14910, unitId = "player", caster = "all", filter = "BUFF" },
			-- 心靈恐慌
			{ spellID = 64044, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 心靈恐慌（繳械效果）
			{ spellID = 64058, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 精神控制
			{ spellID = 605, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沉默
			{ spellID = 15487, unitId = "player", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 束縛不死生物
			{ spellID = 9484, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 心靈尖嘯
			{ spellID = 8122, unitId = "focus", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "CD",
			direction = "DOWN",
			iconSide = "LEFT",
			mode = "BAR",
			size = 28,
			barWidth = 170,
			setpoint = { "LEFT", UIParent, "LEFT", 5, -6 },
			
			--大天使
			{ spellID = 87151, unitId = "player", caster = "player", filter = "CD" },
            --暗影魔
			{ spellID = 34433, unitId = "player", caster = "player", filter = "CD" },
            --真言術:壁
			{ spellID = 62618, unitId = "player", caster = "player", filter = "CD" },
            --影散
			{ spellID = 47585, unitId = "player", caster = "player", filter = "CD" },
            --絕望禱言
			{ spellID = 19236, unitId = "player", caster = "player", filter = "CD" },
		},
	},
	["WARLOCK"]={
		{
			name = "目标debuff",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			direction = "RIGHT",
			mode = "ICON",
			size = 38,
	
			{spellID = 8050, unitId = "target", caster = "target", filter = "DEBUFF"},
			-- Fear / Furcht
			{ spellID = 5782, unitId = "target", caster = "target", filter = "DEBUFF" },
			-- Banish / Verbannen
			{ spellID = 710, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of the Elements / Fluch der Elemente
			{ spellID = 1490, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Tongues / Fluch der Sprachen
			{ spellID = 1714, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Exhaustion / Fluch der Erschöpfung
			{ spellID = 18223, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Weakness / Fluch der Schwäche
			{ spellID = 702, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Corruption / Verderbnis
			{ spellID = 172, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate / Feuerbrand
			{ spellID = 348, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Agony / Omen der Pein
			{ spellID = 980, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Doom / Omen der Verdammnis
			{ spellID = 603, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction / Instabiles Gebrechen
			{ spellID = 30108, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt / Heimsuchung
			{ spellID = 48181, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Seed of Corruption / Saat der Verderbnis
			{ spellID = 27243, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Howl of Terror / Schreckensgeheul
			{ spellID = 5484, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death Coil / Todesmantel
			{ spellID = 6789, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Enslave Demon / Dämonensklave
			{ spellID = 1098, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demon Charge / Dämonischer Ansturm
			{ spellID = 54785, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			name = "玩家重要buff",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			direction = "LEFT",
			size = 38,
			-- Improved Soul Fire / Verbessertes Seelenfeuer
			{ spellID = 85383, unitId = "player", caster = "player", filter = "BUFF" },
			-- Molten Core / Geschmolzener Kern
			{ spellID = 47383, unitId = "player", caster = "player", filter = "BUFF" },
			-- Decimation / Dezimierung
			{ spellID = 63165, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backdraft / Pyrolyse
			{ spellID = 54274, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backlash / Heimzahlen
			{ spellID = 34936, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nether Protection / Netherschutz
			{ spellID = 30299, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nightfall / Einbruch der Nacht
			{ spellID = 18094, unitId = "player", caster = "player", filter = "BUFF" },
			-- Soulburn / Seelenbrand
			{ spellID = 74434, unitId = "player", caster = "player", filter = "BUFF" },
		},
	},
	["ROGUE"] = {
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- 疾跑
			{ spellID = 2983, unitId = "player", caster = "player", filter = "BUFF" },
			-- 暗影披風
			{ spellID = 31224, unitId = "player", caster = "player", filter = "BUFF" },
			-- 能量刺激
			{ spellID = 13750, unitId = "player", caster = "player", filter = "BUFF" },
			-- 閃避
			{ spellID = 5277, unitId = "player", caster = "player", filter = "BUFF" },
			-- 毒化
			{ spellID = 32645, unitId = "player", caster = "player", filter = "BUFF" },
			-- 極限殺戮
			{ spellID = 58426, unitId = "player", caster = "player", filter = "BUFF" },
			-- 切割
			{ spellID = 5171, unitId = "player", caster = "player", filter = "BUFF" },
			-- 偷天換日
			{ spellID = 57934, unitId = "player", caster = "player", filter = "BUFF" },
			-- 偷天換日(傷害之後)
			{ spellID = 59628, unitId = "player", caster = "player", filter = "BUFF" },
			-- 嫁禍栽贓
			{ spellID = 51627, unitId = "player", caster = "player", filter = "BUFF" },
			--养精蓄锐
			{ spellID = 73651, unitId = "player", caster = "player", filter = "BUFF" },
			--剑刃乱舞
			{ spellID = 13877, unitId = "player", caster = "player", filter = "BUFF" },
			--淺察
			{ spellID = 84745, unitId = "player", caster = "player", filter = "BUFF" },
			--中度洞察
			{ spellID = 84746, unitId = "player", caster = "player", filter = "BUFF" },
			--深度洞察
			{ spellID = 84747, unitId = "player", caster = "player", filter = "BUFF" },
			--佯攻
			{ spellID = 1966, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- 偷襲
			{ spellID = 1833, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 腎擊
			{ spellID = 408, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 致盲
			{ spellID = 2094, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 悶棍
			{ spellID = 6770, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- 割裂
			{ spellID = 1943, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 絞喉
			{ spellID = 703, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 鑿擊
			{ spellID = 1776, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 破甲
			{ spellID = 8647, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 卸除武裝
			{ spellID = 51722, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 致命毒藥
			{ spellID = 2818, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 麻痺毒藥
			{ spellID = 5760, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 致殘毒藥
			{ spellID = 3409, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 致傷毒藥
			{ spellID = 13218, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- 出血
			{ spellID = 16511, unitId = "target", caster = "player", filter = "DEBUFF" },

		},
		{
			name = "焦点debuff",
			direction = "UP",
			setpoint = { "BOTTOMLEFT", "oUF_focus", "TOPLEFT", 0, 10 },
			size = 24,
			mode = "BAR",
			iconSide = "LEFT",
			barWidth = 170,
			
			-- 致盲
			{ spellID = 2094, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- 悶棍
			{ spellID = 6770, unitId = "focus", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "CD",
			direction = "DOWN",
			iconSide = "LEFT",
			mode = "BAR",
			size = 28,
			barWidth = 170,
			setpoint = { "LEFT", UIParent, "LEFT", 5, -6 },

			--暗影步
			{ spellID = 36554, filter = "CD" },
			--预备
			{ spellID = 14185, filter = "CD" },
			--疾跑
			{ spellID = 2983, filter = "CD" },
			--斗篷
			{ spellID = 31224, filter = "CD" },
			--闪避
			{ spellID = 5277, filter = "CD" },
			--拆卸
			{ spellID = 51722, filter = "CD" },
			--影舞
			{ spellID = 51713, filter = "CD" },
			--致盲
			{ spellID = 2094, filter = "CD" },
			--战斗就绪
			{ spellID = 74001, filter = "CD" },
			--烟雾弹
			{ spellID = 76577, filter = "CD" },
			--消失
			{ spellID = 1856, filter = "CD" },
			--转攻
			{ spellID = 73981, filter = "CD" },
			--宿怨
			{ spellID = 79140, filter = "CD" },
			--冷血
			{ spellID = 14177, filter = "CD" },
			--狂舞杀戮
			{ spellID = 51690, filter = "CD" },
			--能量刺激
			{ spellID = 13750, filter = "CD" },
		},
	},
	["DEATHKNIGHT"] = {
		{
			name = "玩家重要buff",
			direction = "LEFT",
			setpoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, 38 },
			size = 38,
			
			-- Blood Shield / Blutschild
			{ spellID = 77513, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Force / Unheilige Kraft
			{ spellID = 67383, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Strength / Unheilige Stärke
			{ spellID = 53365, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Might / Unheilige Macht
			{ spellID = 67117, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dancing Rune Weapon / Tanzende Runenwaffe
			{ spellID = 49028, unitId = "player", caster = "player", filter = "BUFF" },
			-- Icebound Fortitude / Eisige Gegenwehr
			{ spellID = 48792, unitId = "player", caster = "player", filter = "BUFF" },
			-- Anti-Magic Shell / Antimagische Hülle
			{ spellID = 48707, unitId = "player", caster = "player", filter = "BUFF" },
			-- Killing Machine / Tötungsmaschine
			{ spellID = 51124, unitId = "player", caster = "player", filter = "BUFF" },
			-- Freezing Fog / Gefrierender Nebel
			{ spellID = 59052, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bone Shield / Knochenschild
			{ spellID = 49222, unitId = "player", caster = "player", filter = "BUFF" },

		},
		{
			name = "目标debuff",
			direction = "RIGHT",
			setpoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, 33 },
			size = 38,
			
			-- Strangulate / Strangulieren
			{ spellID = 47476, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blood Plague / Blutseuche
			{ spellID = 59879, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever / Frostfieber
			{ spellID = 59921, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight / Unheilige Verseuchung
			{ spellID = 49194, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle / Gargoyle beschwören
			{ spellID = 49206, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death and Decay / Tod und Verfall
			{ spellID = 43265, unitId = "target", caster = "player", filter = "DEBUFF" },

		},
	},
	["ALL"]={
		{
			name = "玩家特殊buff",
			direction = "LEFT",
			setpoint = { "TOPRIGHT", "oUF_Player", "BOTTOMRIGHT", 0, -17 },
			size = 41,
			-- 飾品
			
			-- 伊格納修斯之心
			{ spellID = 91027, unitId = "player", caster = "player", filter = "BUFF" },
			-- 伊格納修斯之心 (H)
			{ spellID = 91041, unitId = "player", caster = "player", filter = "BUFF" },
			--暗月卡：火山
			{ spellID = 89091, unitId = "player", caster = "player", filter = "BUFF" },
			--暗月卡：地震
			{ spellID = 89181, unitId = "player", caster = "player", filter = "BUFF" },
			--狂怒共鸣之铃(H)
			{ spellID = 91007, unitId = "player", caster = "player", filter = "BUFF" },
			--瑟拉里恩之鏡
			{ spellID = 91024, unitId = "player", caster = "player", filter = "BUFF" },
			--绝境当头
			{ spellID = 96907, unitId = "player", caster = "player", filter = "BUFF" },
			--恶魔领主之赐
			{ spellID = 102662, unitId = "player", caster = "player", filter = "BUFF" },
			--腐败心灵徽记(普通模式)
			{ spellID = 107982, unitId = "player", caster = "player", filter = "BUFF" },
			--堕落心灵印记(H)
			{ spellID = 109789, unitId = "player", caster = "player", filter = "BUFF" },
			--死灵法术集核(H)
			{ spellID = 97131, unitId = "player", caster = "player", filter = "BUFF" },
			--死灵法术集核
			{ spellID = 96962, unitId = "player", caster = "player", filter = "BUFF" },
			--魂棺
			{ spellID = 91019, unitId = "player", caster = "player", filter = "BUFF" },
			--秘银码表
			{ spellID = 101291, unitId = "player", caster = "player", filter = "BUFF" },
			--瓦罗森的胸针
			{ spellID = 102664, unitId = "player", caster = "player", filter = "BUFF" },
			--圣光念珠
			{ spellID = 102660, unitId = "player", caster = "player", filter = "BUFF" },
			--H無縛之怒  觸發buff名字:作戰狀態 X
			{ spellID =109719, unitId = "player", caster = "player", filter = "BUFF" },
			--H淨縛之意志  觸發buff名字:鬥心 X
			{ spellID =109795, unitId = "player", caster = "player", filter = "BUFF" },
			--H無命之心 觸發buff名字:開闊思維 X
			{ spellID =109813, unitId = "player", caster = "player", filter = "BUFF" },
			--H壞滅之眼  觸發buff名字:泰坦之力 X
			{ spellID =77997, unitId = "player", caster = "player", filter = "BUFF" },
			--H不朽的決心  觸發buff名字:超自然閃避 X
 			{ spellID =109782, unitId = "player", caster = "player", filter = "BUFF" },
			--H七徵聖印   觸發buff名字:速度
			{ spellID =109804, unitId = "player", caster = "player", filter = "BUFF" },
			--H靈魂轉移者漩渦  觸發buff名字:戰術大師 
			{ spellID =109776, unitId = "player", caster = "player", filter = "BUFF" },
			--H末代之龍的誕生塑像   觸發buff名字:找尋弱點
			{ spellID =109744, unitId = "player", caster = "player", filter = "BUFF" },
			--H擒星羅盤   觸發buff名字:速度
			{ spellID =109711,unitId = "player", caster = "player", filter = "BUFF" },
			--H基洛提瑞克符印  觸發buff名字:輕靈
			{ spellID =109715, unitId = "player", caster = "player", filter = "BUFF" },
			--H瓶裝願望   觸發buff名字:究極之力
			{ spellID =109792, unitId = "player", caster = "player", filter = "BUFF" },
			--H腐爛頭顱  觸發buff名字:泰坦之力
			{ spellID =109747, unitId = "player", caster = "player", filter = "BUFF" },
			--H深淵之火  觸發buff名字:難以捉摸
			{ spellID =109779, unitId = "player", caster = "player", filter = "BUFF" }, 
			--無縛之怒  觸發buff名字:作戰狀態 X
			{ spellID =107960, unitId = "player", caster = "player", filter = "BUFF" },
			--無命之心  觸發buff名字:開闊思維 X
 			{ spellID =107962, unitId = "player", caster = "player", filter = "BUFF" },
			--壞滅之眼  觸發buff名字:泰坦之力 X
			{ spellID =107967, unitId = "player", caster = "player", filter = "BUFF" },
			--不朽的決心  觸發buff名字:超自然閃避 X
			{ spellID =107968, unitId = "player", caster = "player", filter = "BUFF" },
			--基洛提瑞克符印 觸發buff名字:輕靈
 			{ spellID =107947, unitId = "player", caster = "player", filter = "BUFF" },
			--瓶裝願望  觸發buff名字:究極之力
			{ spellID =107948, unitId = "player", caster = "player", filter = "BUFF" },
			--聖光倒影  觸發buff名字:究極之力
			{ spellID =107948, unitId = "player", caster = "player", filter = "BUFF" },
			--腐爛頭顱  觸發buff名字:泰坦之力
			{ spellID =107949, unitId = "player", caster = "player", filter = "BUFF" },
			--深淵之火  觸發buff名字:難以捉摸
			{ spellID =107951, unitId = "player", caster = "player", filter = "BUFF" },
			--末代之龍的誕生塑像  觸發buff名字:找尋弱點
			{ spellID =107988, unitId = "player", caster = "player", filter = "BUFF" },
			--靈魂轉移者漩渦  觸發buff名字:戰術大師
			{ spellID =107986, unitId = "player", caster = "player", filter = "BUFF" },
			--時間之箭  觸發buff名字:時間之箭
			{ spellID =102659, unitId = "player", caster = "player", filter = "BUFF" },
			--惡魔領主之賜  觸發buff名字:邪惡之禮 
 			{ spellID =109908, unitId = "player", caster = "player", filter = "BUFF" },
			--L七徵聖印  觸發buff名字:速度
			{ spellID =109802, unitId = "player", caster = "player", filter = "BUFF" },
			--L腐敗心靈徽記  觸發buff名字:速度
 			{ spellID =109802, unitId = "player", caster = "player", filter = "BUFF" },
			--L擒星羅盤  觸發buff名字:速度
 			{ spellID =109802, unitId = "player", caster = "player", filter = "BUFF" },
			--L無縛之怒 X 觸發buff名字:作戰狀態
			{ spellID =109717, unitId = "player", caster = "player", filter = "BUFF" },
			--L淨縛之意志  X  觸發buff名字:鬥心
			{ spellID =109793, unitId = "player", caster = "player", filter = "BUFF" },
			--L無命之心 X  觸發buff名字:開闊思維
 			{ spellID =109811, unitId = "player", caster = "player", filter = "BUFF" },
			--L壞滅之眼  X   觸發buff名字:泰坦之力
			{ spellID =109748, unitId = "player", caster = "player", filter = "BUFF" },
			--L不朽的決心  X 觸發buff名字:超自然閃避
			{ spellID =109780, unitId = "player", caster = "player", filter = "BUFF" },
		-- 工程
			-- 神經突觸彈簧(敏捷)
			{ spellID = 96228, unitId = "player", caster = "player", filter = "BUFF" },
			-- 神經突觸彈簧(力量)
			{ spellID = 96229, unitId = "player", caster = "player", filter = "BUFF" },
			-- 神經突觸彈簧(智力)
			{ spellID = 96230, unitId = "player", caster = "player", filter = "BUFF" },

		-- 裁縫
			-- 暗輝刺繡
			{ spellID = 75173, unitId = "player", caster = "player", filter = "BUFF" },
			-- 光紋刺繡
			{ spellID = 75170, unitId = "player", caster = "player", filter = "BUFF" },
			-- 劍衛刺繡
			{ spellID = 75176, unitId = "player", caster = "player", filter = "BUFF" },

		-- 武器附魔
			-- 心之歌
			{ spellID = 74224, unitId = "player", caster = "player", filter = "BUFF" },
			-- 颶風
			{ spellID = 74221, unitId = "player", caster = "player", filter = "BUFF" },
			--能量洪流
			{ spellID = 74241, unitId = "player", caster = "player", filter = "BUFF" },
			--轻盈步伐
			{ spellID = 74243, unitId = "player", caster = "player", filter = "BUFF" },

		-- 藥水
			-- 土靈護甲
			{ spellID = 79475, unitId = "player", caster = "player", filter = "BUFF" },
			--火山藥水
			{ spellID = 79476, unitId = "player", caster = "player", filter = "BUFF" },

		-- 特殊buff
			-- 偷天換日
			{ spellID = 57933, unitId = "player", caster = "all", filter = "BUFF" },
			-- 注入能量
			{ spellID = 10060, unitId = "player", caster = "all", filter = "BUFF" },
			-- 嗜血術
			{ spellID = 2825, unitId = "player", caster = "all", filter = "BUFF" },
			-- 英勇氣概
			{ spellID = 32182, unitId = "player", caster = "all", filter = "BUFF" },
			-- 時間扭曲
			{ spellID = 80353, unitId = "player", caster = "all", filter = "BUFF" },
			-- 上古狂亂
			{ spellID = 90355, unitId = "player", caster = "all", filter = "BUFF" },
		},
		
		
		{
			name = "PVE/PVP玩家debuff",
			direction = "UP",
			setpoint = { "BOTTOM", UIParent, "BOTTOM", -35, 350 },
			size = 51,
			
		
			
		-- Death Knight
			-- 啃食
			{ spellID = 47481, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 絞殺
			{ spellID = 47476, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰鏈術
			{ spellID = 45524, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 褻瀆
			{ spellID = 55741, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 碎心打擊
			{ spellID = 58617, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 噬溫酷寒
			{ spellID = 49203, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Druid
			-- 颶風術
			{ spellID = 33786, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 休眠
			{ spellID = 2637, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 重擊
			{ spellID = 5211, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 傷殘術
			{ spellID = 22570, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 突襲
			{ spellID = 9005, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 糾纏根鬚
			{ spellID = 339, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 野性衝鋒效果
			{ spellID = 45334, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 感染之傷
			{ spellID = 58179, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Hunter
			-- 冰凍陷阱
			{ spellID = 3355, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 恐嚇野獸
			{ spellID = 1513, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 驅散射擊
			{ spellID = 19503, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 奪械
			{ spellID = 50541, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沈默射擊
			{ spellID = 34490, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 脅迫
			{ spellID = 24394, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 音波沖擊
			{ spellID = 50519, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 劫掠
			{ spellID = 50518, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 震盪狙擊
			{ spellID = 35101, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 震盪射擊
			{ spellID = 5116, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 寒冰陷阱
			{ spellID = 13810, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 凍痕
			{ spellID = 61394, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 摔絆
			{ spellID = 2974, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 反擊
			{ spellID = 19306, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 誘捕
			{ spellID = 19185, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 釘刺
			{ spellID = 50245, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 噴灑毒網
			{ spellID = 54706, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 蛛網
			{ spellID = 4167, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 霜暴之息
			{ spellID = 92380, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 裂筋
			{ spellID = 50271, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Mage
			-- 龍之吐息
			{ spellID = 31661, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 衝擊波
			{ spellID = 11113, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 活體爆彈
			{ spellID = 44457, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 變形術
			{ spellID = 118, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沉默 - 強化法術反制
			{ spellID = 18469, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 極度冰凍
			{ spellID = 44572, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰凍術
			{ spellID = 33395, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰霜新星
			{ spellID = 122, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 碎裂屏障
			{ spellID = 55080, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰凍
			{ spellID = 6136, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰錐術
			{ spellID = 120, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 減速術
			{ spellID = 31589, unitId = "player", caster = "all", filter = "DEBUFF" },			
			-- 強化冰錐術
			{ spellID = 83301, unitId = "player", caster = "all", filter = "DEBUFF" },
			{ spellID = 83302, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Paladin
			-- 懺悔
			{ spellID = 20066, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 退邪術
			{ spellID = 10326, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 暈眩 - 復仇之盾
			{ spellID = 63529, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 制裁之錘
			{ spellID = 853, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 神聖憤怒
			{ spellID = 2812, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 公正聖印
			{ spellID = 20170, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 復仇之盾
			{ spellID = 31935, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Priest
			-- 心靈恐慌（繳械效果）
			{ spellID = 64058, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 精神控制
			{ spellID = 605, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 心靈恐慌
			{ spellID = 64044, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 心靈尖嘯
			{ spellID = 8122, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沉默
			{ spellID = 15487, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 精神鞭笞
			{ spellID = 15407, unitId = "player", caster = "all", filter = "DEBUFF" },
			--罪與罰
			{ spellID = 87204, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Rogue
			-- 卸除武裝
			{ spellID = 51722, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 致盲
			{ spellID = 2094, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 鑿擊
			{ spellID = 1776, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 悶棍
			{ spellID = 6770, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 絞喉 - 沉默
			{ spellID = 1330, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沉默 - 強化腳踢
			{ spellID = 18425, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 偷襲
			{ spellID = 1833, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 腎擊
			{ spellID = 408, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 旋轉劍刃
			{ spellID = 31125, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 致殘毒藥
			{ spellID = 3409, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 擲殺
			{ spellID = 26679, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Shaman
			-- 妖術
			{ spellID = 51514, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 陷地
			{ spellID = 64695, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 凍結
			{ spellID = 63685, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 石爪昏迷
			{ spellID = 39796, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 地縛術
			{ spellID = 3600, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰霜震擊
			{ spellID = 8056, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Warlock
			-- 放逐術
			{ spellID = 710, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 死亡纏繞
			{ spellID = 6789, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 恐懼術
			{ spellID = 5782, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 恐懼嚎叫
			{ spellID = 5484, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 誘惑
			{ spellID = 6358, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 法術封鎖
			{ spellID = 24259, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 暗影之怒
			{ spellID = 30283, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 追獵
			{ spellID = 30153, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 清算
			{ spellID = 18118, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 疲勞詛咒
			{ spellID = 18223, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Warrior
			-- 破膽怒吼
			{ spellID = 20511, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 繳械
			{ spellID = 676, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 沉默 - 窒息律令
			{ spellID = 18498, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 衝鋒昏迷
			{ spellID = 7922, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 震盪猛擊
			{ spellID = 12809, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 攔截
			{ spellID = 20253, unitId = "player", caster = "all", filter = "DEBUFF" },
            -- 震懾波
			{ spellID = 46968, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 斷筋雕紋
			{ spellID = 58373, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 強化斷筋
			{ spellID = 23694, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 斷筋
			{ spellID = 1715, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 刺耳怒吼
			{ spellID = 12323, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- Racials
			-- 戰爭踐踏
			{ spellID = 20549, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- 副本
		-- 暮光堡壘
		    -- 致死打擊 (哈福斯·破龍者)
			{ spellID = 39171, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 昏天暗地 (瑟拉里恩和瓦莉歐娜)
			{ spellID = 92879, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 侵蝕魔法 (瑟拉里恩和瓦莉歐娜)
            { spellID = 86622, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 暮光隕星 (瑟拉里恩和瓦莉歐娜)
            { spellID = 88518, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 侵濕 (卓越者議會)
			{ spellID = 82762, unitId = "player", caster = "all", filter = "DEBUFF" }, 
			-- 聚雷針 (卓越者議會)
             { spellID = 83099, unitId = "player", caster = "all", filter = "DEBUFF" }, 
			-- 旋風 (卓越者議會)
			{ spellID = 83500, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 磁力吸引 (卓越者議會)
			{ spellID = 83587, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 腐化:畸形 (丘加利)
			{ spellID = 82125, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 腐化:絕對 (丘加利)
			{ spellID = 82170, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 腐化:疾病 (丘加利)
			{ spellID = 93200, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- 黑翼魔窟
			-- 寄生感染 (熔喉)
			{ spellID = 94679, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 傳染嘔吐 (熔喉)
			{ spellID = 91923, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 聚雷針 (全能魔像防禦系統)
			{ spellID = 91433, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 闇能灌注 (全能魔像防禦系統)
			{ spellID = 92048, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 瞬間冷凍 (瑪洛里亞克)
			{ spellID = 77699, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 吞噬烈焰 (瑪洛里亞克)
			{ spellID = 77786, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 聚影體 (全能魔像防禦系統)
			{ spellID = 92053, unitId = "player", caster = "all", filter = "DEBUFF" },
			--爆裂灰燼（h奈法利安的末路）
            { spellID = 79339, size = 55, unitId = "player", caster = "all", filter = "DEBUFF" },

		-- 四風
			-- 風寒冷卻 (四風議會)
			{ spellID = 93123, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 削骨颶風 (四風議會)
			{ spellID = 93058, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 靜電震擊 (奧拉基爾)
			{ spellID = 87873, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 酸雨 (奧拉基爾)
			{ spellID = 93279, unitId = "player", caster = "all", filter = "DEBUFF" },
			
		-- 火源
			-- 燃燒之球
			{ spellID = 98451, unitId = "player", caster = "all", filter = "DEBUFF" },
			--活力火花
            { spellID = 99262, unitId = "player", caster = "all", filter = "BUFF" },
            --活力烈焰
			{ spellID = 99263, unitId = "player", caster = "all", filter = "BUFF" },
			--火焰易傷
			{ spellID = 98492, unitId = "player", caster = "all", filter = "DEBUFF" },
			--爆裂種子
			{ spellID = 98450, unitId = "player", caster = "all", filter = "DEBUFF" },
			
		-- 龍魂
			-- 魔寇
			-- 安全
			{ spellID = 103541, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 警告
			{ spellID = 103536, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 危險
			{ spellID = 103534, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 督軍松奧茲
			-- 崩解之影
			{ spellID = 103434, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 未眠者尤沙吉
			-- 深度腐化
			{ spellID = 103628, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 哈甲拉
			-- 目標
			{ spellID = 105285, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 破碎寒冰
			{ spellID = 105289, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 奧特拉賽恩
			-- 黑暗逼近
			{ spellID = 106498, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 凋零之光
			{ spellID = 109075, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 將領黑角
			-- 暮光彈幕
			{ spellID = 109204, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 死亡之翼的脊椎
			-- 纏繞觸鬚
			{ spellID = 105563, unitId = "player", caster = "all", filter = "DEBUFF" },

		},
		{
			name = "PVP目标buff",
			direction = "UP",
			setpoint = { "BOTTOM", UIParent, "BOTTOM", 35, 350 },
			size = 51,
			
			
			-- 豹群
			{ spellID = 13159, unitId = "player", caster = "player", filter = "BUFF" },
			-- 啟動
			{ spellID = 29166, unitId = "target", caster = "all", filter = "BUFF"},
			-- 法術反射
			{ spellID = 23920, unitId = "target", caster = "all", filter = "BUFF" },
			-- 精通光環
			{ spellID = 31821, unitId = "target", caster = "all", filter = "BUFF" },
			-- 寒冰屏障
			{ spellID = 45438, unitId = "target", caster = "all", filter = "BUFF" },
			-- 暗影披風
			{ spellID = 31224, unitId = "target", caster = "all", filter = "BUFF" },
			-- 聖盾術
			{ spellID = 642, unitId = "target", caster = "all", filter = "BUFF" },
			-- 威懾
			{ spellID = 19263, unitId = "target", caster = "all", filter = "BUFF" },
			-- 反魔法護罩
			{ spellID = 48707, unitId = "target", caster = "all", filter = "BUFF" },
			-- 巫妖之軀
			{ spellID = 49039, unitId = "target", caster = "all", filter = "BUFF" },
			-- 自由聖禦
			{ spellID = 1044, unitId = "target", caster = "all", filter = "BUFF" },
			-- 犧牲聖禦
			{ spellID = 6940, unitId = "target", caster = "all", filter = "BUFF" },
			-- 根基圖騰效果
			{ spellID = 8178, unitId = "target", caster = "all", filter = "BUFF" },
			--保護聖禦
            { spellID = 1022, unitId= "target", caster = "all", filter = "BUFF" },

		},
	},
}