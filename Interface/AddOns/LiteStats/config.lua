-- LiteStats configuration file
-- BACKUP YOUR CHANGES TO THIS FILE BEFORE UPDATING!

-- To install, simply rename this file to config.lua and edit any of the values below to customize.

-- Stat font style configuration.
-- Please see the memory module configuration for information on changing individual stat appearances.
LPSTAT_FONT = {
	font = "Fonts\\ARIALN.ttf", -- Path to your font.
	color = {1,1,1},        -- {red,green,blue} (0.0-1.0 only) or "CLASS"
	size = 12,               -- Point font size.
	alpha = 1,            -- % Alpha transparency.
	outline = 1,            -- 1=Thin outline, 2=Thick outline, 0=no outline
	shadow = {alpha=1,x=0}, -- shadow = 1 is the same as shadow = { color="0 0 0", alpha=1, x=1, y=-1 }
}

LTIPICONSIZE = 20 -- Icon sizes in info tips. Depending on your tooltip configurations, you may want to change this.

--[[ Set to true to enable in-combat hiding for all texts.
   - To enable on a per-stat basis, set this to false and add incombat = true to their config.
   - To disable on a per-stat basis, set this to true and add incombat = false to their config.
]]
HIDE_IN_COMBAT = false

--[[ Player class coloring function for optional use with fmt strings config.
   - Example use: fmt = class'G:'.." %d"..class'/'.."%d" (colors 'G:' and '/' and numbers retain the default text color)
   - Example2: fmt = class'%d'.."fps" (colors the fps number and "fps" retains the default text color).
]]
local ctab = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local function class(string)
	local color = ctab[select(2,UnitClass'player')]
	return format("|cff%02x%02x%02x%s|r",color.r*255,color.g*255,color.b*255,string or '')
end

--[[ Modules Config. Note: omitting any variable will likely cause errors, check carefully when updating.
   - More tip_anchor strings: http://www.wowwiki.com/API_GameTooltip_SetOwner
   - To color any of your 'fmt' strings, use hex format ("|cffFFFF55*string*|r") or the class format described above.
   - You can start a new line by using '\n' in your format strings.
]]
LPSTAT_CONFIG = {
	Memory = {
		enabled = true,
		fmt_mb = "%.1fmb", -- "12.5mb"
		fmt_kb = "%.0fkb", -- "256kb" - only shows if memory is under one megabyte
		max_addons = 25,   -- Set to nil or comment/delete this line to disable. Holding Alt reveals hidden addons.
		anchor_frame = "Latency", anchor_to = "right", anchor_from = "left",
		x_off = -10, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0,

		-- note: you may override font appearance by using the same attributes in LPSTAT_FONT here:
	 	-- size = 10, color = {0.5, 0.5, 0.5},
	},
	FPS = {
		enabled = true,
		fmt = "%dfps", -- "42fps"
		anchor_frame = "Memory", anchor_to = "right", anchor_from = "left",
		x_off = -10, y_off = 0,
	},
	Latency = {
		enabled = true,
		fmt = "[color]%d|rms",   -- "77ms", [color] inserts latency color code.
	 	anchor_frame = "Durability", anchor_to = "right", anchor_from = "left",
		x_off = -10, y_off = 0,
	},
	Durability = {
		enabled = true,
		fmt = "D: [color]%d|r%%",  -- "54%D" -- %% outputs %, [color] inserts durability color code.
		man = true,              -- Hide bliz durability man.
		gfunds = true,           -- Change to false to disable guild repairing.
		ignore_inventory = true, -- Ignore inventory gear when auto-repairing.
		gear_icons = false,      -- Show your gear icons in the tooltip.
		anchor_frame = "Bags", anchor_to = "right", anchor_from = "left",
		x_off = -10, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Gold = {
		enabled = false, -- To clear all money data: /script for _,t in pairs(LPSTAT) do if type(t)=='table' then t.Gold = nil end end
		style = 2,      -- Display styles: [1] 55g 21s 11c [2] 8829.4g [3] 823.55.94
		anchor_frame = "Durability", anchor_to = "right", anchor_from = "left",
		x_off = -3, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Clock = {
		enabled = true,                  -- Local time and the 24 hour clock can be enabled in-game via time manager (right-click)
		AM = "A", PM = "P", colon = ":", -- These values apply to the displayed clock.
		anchor_frame = "Minimap", anchor_to = "bottom", anchor_from = "bottom",font = "Fonts\\ARIALN.ttf", size = 12,
		x_off = 0, y_off = 10, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Location = {
		enabled = true,
		subzone = true,      -- Set to false to display the main zone's name instead of the subzone.
		truncate = 18,       -- Max number of letters for location text, set to 0 to disable.
		coord_fmt = "%d,%d", -- "44,19", to add tenths, use '%.1f' (digit determines decimal)
		anchor_frame = "Minimap", anchor_to = "top", anchor_from = "top",
		x_off = 0, y_off = -3, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Coords = {
		enabled = false, -- Location tooltip has coords, this module is for displaying it as a separate stat.
		fmt = "%d, %d",  -- "44,19"
		anchor_frame = "Minimap", anchor_to = "top", anchor_from = "top",
		x_off = 0, y_off = -10
	},
	Ping = {
		enabled = true,
		fmt = "|cffff5555*|r %s |cffff5555*|r", -- "* Katae *"
		hide_self = false,                      -- Hide player's ping.
		anchor_frame = "Minimap", anchor_to = "bottom", anchor_from = "bottom",
		x_off = -10, y_off = 25,
	},
	DPS = {
		enabled = false,
		combat = false,
		fmt = "D:%s", short = true,
		hide_inactive = true, -- Hides dps text after 10 seconds of inactivity
		anchor_frame = "Minimap", anchor_to = "bottom", anchor_from = "bottom",
		x_off = 0, y_off = -15,
	},
	Guild = {
		enabled = true,
		fmt = "G:%d",  -- "G:5" (add another %d for total guild members value)
		maxguild = nil,    -- Set max members listed, nil means no limit. Alt-key reveals hidden members.
		threshold = 1,     -- Minimum level displayed (1-80).
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note.
		anchor_frame = "FPS", anchor_to = "left", anchor_from = "top",
		x_off = -42, y_off = -6, --tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Friends = {
		enabled = false,
		fmt = "F:%d", -- "F:3" (add another %d for total friends value)
		maxfriends = nil, -- Set max friends listed, nil means no limit.
		anchor_frame = "Guild", anchor_to = "left", anchor_from = "top",
		x_off = -35, y_off = -6, --tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Bags = {
		enabled = true,
		fmt = "B:%d", -- "B:24" (add another %d for total bag space value)
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		x_off = -10, y_off = 10,
	},
	Mail = {
		enabled = false,
		newmail = "|cff55FF55New Mail!", nomail = "", -- Set the text for new or no mail.
		anchor_frame = "Minimap", anchor_to = "right", anchor_from = "topleft",
		x_off = -45, y_off = -100, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Talents = {
		enabled = true,
		fmt = "[icon] [name]: [spec %d/%d/%d] [unspent]", -- "Protection: 15/0/51 +5", [shortname] shortens spec name.
		iconsize = 16,  -- Size of talent [icon].
		name_subs = {   -- Substitutions for long talent tree names, remove and/or change any/all.
			["Protection"] = "Prot",
			["Restoration"] = "Resto",
			["Feral Combat"] = "Feral",
			["Retribution"] = "Ret",
			["Discipline"] = "Disc",
			["Enhancement"] = "Enhance",
			["Elemental"] = "Ele",
			["Demonology"] = "Demon",
			["Destruction"] = "Destro",
			["Assassination"] = "Assassin",
			["Marksmanship"] = "Marks",
			["Beast Mastery"] = "BM",
		},
		anchor_frame = "Guild", anchor_to = "right", anchor_from = "topleft",
		x_off = -10, y_off = -7, --tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = 0
	},
	Stats = {
		enabled = false,
		--[[ Available stat tags...
		   - Attack Power [ap]           Ranged Attack Power [rangedap]	Armor Penetration% [armorpen]
		   - Expertise% [expertise]      Melee Hit% [meleehit]          Ranged Hit% [rangedhit]
		   - Spell Hit% [spellhit]       Melee Haste [meleehaste]       Ranged Haste% [rangedhaste]
		   - Spell Haste% [spellhaste]   Melee Crit% [meleecrit]        Ranged Crit% [rangedcrit]
 		   - Spell Crit% [spellcrit]     Spellpower [spellpower]        Healing [healing]
		   - Spell Pen [spellpen]        Dodge% [dodge]                 Parry% [parry]
		   - Block% [block]              Defense Rating [defense]       Avoidance% [avoidance]
		   - MP5 I5SR [manaregen]        Armor Value [armor] 
		]]
		spec1fmt = "AP:[ap] Crit:[meleecrit]% Hit:[meleehit]%",          -- Spec 1 string
		spec2fmt = "Def:[defense] Armor:[armor] Avoidance:[avoidance]%", -- Spec 2 string
		anchor_frame = "UIParent", anchor_to = "top", anchor_from = "top",
		x_off = 0, y_off = -25,
	},
	Experience = {
		enabled = false,
		--[[ Experience & Played tags...
		   - Player Level [level]
		   - Current XP [curxp]             Max XP [totalxp]               Current/Max% [cur%]
		   - Remaining XP [remainingxp]     Remaining% [remaining%]
		   - Session Gained [sessiongained] Session Rate [sessionrate]     Session Time To Level [sessionttl]
		   - Level Rate [levelrate]         Level Time To Level [levelttl]
		   - Rested XP [rest]               Rested/Level% [rest%]
		   - Quests To Level [questsleft]   Kills To Level [killsleft]
		   - Total Played [playedtotal]     Level Played [playedlevel]     Session Played [playedsession]
		]]
		xp_normal_fmt = "L[level] - [curxp]/[totalxp] ([cur%]%)", -- XP string used when not rested.
		xp_rested_fmt = "L[level] - [curxp]/[totalxp] ([cur%]%) R:[restxp]|r ([rest%]%)", -- XP string used when rested.		
		played_fmt = "Session Played: [playedsession]", -- Played time format.
		short = true, thousand = "k", million = "m",    -- Short numbers ("4.5m" "355.3k")
		
		-- Uncomment below to customize time labels	
		-- day = "d", hour = "h", minute = "m", second = "s",
			
		--[[ Faction tags...
		   - Faction name [repname]
		   - Standing Color Code [repcolor] Standing Name [standing]
		   - Current Rep [currep]           Current Rep Percent [rep%]
		   - Rep Left [repleft]             Max. Rep [maxrep]
		]]
		faction_fmt = "[repname]: [repcolor][currep]/[maxrep]|r ([standing])",
		faction_subs = {
		--["An Very Long Rep Name"] = "Shortened",
			["The Wyrmrest Accord"] = "Wyrmrest",
			["Knights of the Ebon Blade"] = "Ebon Blade",
		},
		anchor_frame = "UIParent", anchor_to = "top", anchor_from = "top",
		x_off = 0, y_off = -15, tip_anchor = "ANCHOR_BOTTOM", tip_x = 0, tip_y = 0
	},
}

LPSTAT_PROFILES = {
	["Name - Realm"] = {
		-- To change modules on a per-character basis, copy and paste any or all of
		-- the default module configs here and modify them at will.
		DPS = { enabled = false },
		Experience = { enabled = false },
		Stats = { spec1fmt = "[spellpower]SP ~ [manaregen]mp5" }
	},
	MAGE = { -- Class profile format, name must be enUS localized string (WARRIOR, DEATHKNIGHT, PRIEST).
		DPS = { enabled = true },
	},
}
