local ADDON_NAME, ns = "oUF_Freebgrid", Freebgrid_NS

local indicator = ns.mediapath.."squares.ttf"
local symbols = ns.mediapath.."PIZZADUDEBULLETS.ttf"

ns.outline = {
    ["NONE"] = "无",
    ["OUTLINE"] = "OUTLINE",
    ["THINOUTLINE"] = "THINOUTLINE",
    ["MONOCHROME"] = "MONOCHROME",
    ["OUTLINEMONO"] = "OUTLINEMONOCHROME",
}

ns.orientation = {
    ["VERTICAL"] = "垂直",
    ["HORIZONTAL"] = "水平",
}

local hptext = {
	["DEFICIT"] 	= "显示缺失的生命值",
	["PERC"]		= "显示生命值百分比",
	["ACTUAL"]		= "显示当前生命值",
}

local dispeltext = {
	["NONE"]		= "不显示",
	["ICON"] 		= "只显示图标",
	["BORDER"]		= "图标+边框显示",
	["INDICATOR"]	= "图标+右侧指示器显示",
}
local macroedit = {
	hidden = true,
	path = nil,
	keyname = "",
}
local defaultvalues = {
	["NONE"] = "无",
	["target"] = "目标 ",
	["menu"] = "菜单 ",
	["follow"] = "跟随",
	["macro"] = "宏 ",
}
local default_spells = {
	PRIEST = { 
			139,			--"恢復",
			527,			--"驅散魔法",
			2061,			--"快速治療",
			2006,			--"復活術",
			17,				--"真言術:盾",
			33076,			--"癒合禱言",
			528,			--"驅除疾病", 
			2060,			--"強效治療術",
			32546,			--"束縛治療",
			34861,			--"治療之環",
			2050,			--治疗术
			1706,			--漂浮术
			21562,			--耐
			596,			--治疗祷言
			47758,			-- 苦修
			73325,			-- 信仰飞跃	
			48153,			-- 守护之魂
			88625,			-- 圣言术
			33206,			--痛苦压制
	},
	
	DRUID = { 
			774,			--"回春術",
			2782,			--"净化腐蚀",
			8936,			--"癒合",
			50769,			--"復活",
			48438,			--"野性成长",
			18562,			--"迅捷治愈",
			50464,			--"滋補術",
			1126,			-- 野性印记
			33763,			--"生命之花",
			5185,			--治疗之触
			20484,			--复生,
			29166,			--激活
			33763,			--生命之花
	},
	SHAMAN = { 
			974,			--"大地之盾",
			2008,			--"先祖之魂",
			8004,			--"治疗之涌",
			1064,			--"治疗链",
			331,			--"治疗波",
			51886,			--"净化灵魂",
			546,			--水上行走
			131,			--水下呼吸
			61295,			--"激流",
			77472,			--"强效治疗波",	
			73680,			--"元素释放",
	},

	PALADIN = { 
			635,			--"聖光術",
			19750,			--"聖光閃現",
			53563,			--"圣光信标",
			7328,			--"救贖",
		    20473,			--"神聖震擊",
			82326,			--"神圣之光",
			4987,			--"淨化術",
			85673,			--"荣耀圣令",
			633,			--"聖療術",
		    31789,			--正義防護
			1044,			--自由之手
			31789,			-- 正义防御
			1022,			--"保护之手",
			6940,  		--牺牲之手
			1038,			--"拯救之手",
	},

	WARRIOR = { 
			50720,			--"戒備守護",
			3411,			--"阻擾",
	},

	MAGE = { 
			1459,			--"秘法智力",
			54646,			--"专注",
			475,			--"解除詛咒",
			130,			--"缓落",
	},

	WARLOCK = { 
			80398,			--"黑暗意图",
			5697,			--"魔息",
	},

	HUNTER = { 
			34477,			--"誤導",
			136,			--治疗宠物
	},
	
	ROGUE = { 
			57933,			--"偷天換日",
	},
	
	DEATHKNIGHT = {
			61999,			--复活盟友
			47541,			--死缠
			49016,			-- 邪恶狂乱（邪恶天赋)
	},
}

local  SetClickKeyvalue  = function(val,path1,path2,name)
	if val == "macro" then
		ns.db.ClickCastset[path1][path2]["action"] = "macro"
		macroedit.hidden = false
		macroedit.keyname = name
		macroedit.path = ns.db.ClickCastset[path1][path2]
	else
		ns.db.ClickCastset[path1][path2]["action"]  = val
		macroedit.hidden = true
		macroedit.path =nil
		macroedit.keyname = ""
	end
end		

local function updateFonts(object)
    object.Name:SetFont(ns.db.fontPath, ns.db.fontsize, ns.db.outline)
    object.Name:SetWidth(ns.db.width)
    object.AFKtext:SetFont(ns.db.fontPath, ns.db.fontsizeEdge, ns.db.outline)
    object.AFKtext:SetWidth(ns.db.width)
    object.AuraStatusCen:SetFont(ns.db.fontPath, ns.db.fontsizeEdge, ns.db.outline) 
    object.AuraStatusCen:SetWidth(ns.db.width)
    object.Healtext:SetFont(ns.db.fontPath, ns.db.fontsizeEdge, ns.db.outline) 
    object.Healtext:SetWidth(ns.db.width)
end

local function updateIndicators(object)
    object.AuraStatusTL:SetFont(indicator, ns.db.indicatorsize, "THINOUTLINE")
    object.AuraStatusTR:SetFont(indicator, ns.db.indicatorsize, "THINOUTLINE")
    object.AuraStatusBL:SetFont(indicator, ns.db.indicatorsize, "THINOUTLINE")
	object.AuraStatusRC:SetFont(symbols, ns.db.symbolsize-2, "THINOUTLINE")
    object.AuraStatusBR:SetFont(symbols, ns.db.symbolsize, "THINOUTLINE")

end

local function updateIcons(object)
    object.Leader:SetSize(ns.db.leadersize, ns.db.leadersize)
    object.Assistant:SetSize(ns.db.leadersize, ns.db.leadersize)
    object.MasterLooter:SetSize(ns.db.leadersize, ns.db.leadersize)
    object.RaidIcon:SetSize(ns.db.leadersize+2, ns.db.leadersize+2)
    object.ReadyCheck:SetSize(ns.db.leadersize, ns.db.leadersize)
    object.freebAuras.button:SetSize(ns.db.aurasize, ns.db.aurasize)
    object.freebAuras.size = ns.db.aurasize
end

local function updateHealbar(object)
    object.myHealPredictionBar:ClearAllPoints()
    object.otherHealPredictionBar:ClearAllPoints()

    if ns.db.orientation == "VERTICAL" then
        object.myHealPredictionBar:SetPoint("BOTTOMLEFT", object.Health:GetStatusBarTexture(), "TOPLEFT", 0, 0)
        object.myHealPredictionBar:SetPoint("BOTTOMRIGHT", object.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.myHealPredictionBar:SetSize(0, ns.db.height)
        object.myHealPredictionBar:SetOrientation"VERTICAL"

        object.otherHealPredictionBar:SetPoint("BOTTOMLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPLEFT", 0, 0)
        object.otherHealPredictionBar:SetPoint("BOTTOMRIGHT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.otherHealPredictionBar:SetSize(0, ns.db.height)
        object.otherHealPredictionBar:SetOrientation"VERTICAL"
    else
        object.myHealPredictionBar:SetPoint("TOPLEFT", object.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.myHealPredictionBar:SetPoint("BOTTOMLEFT", object.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        object.myHealPredictionBar:SetSize(ns.db.width, 0)
        object.myHealPredictionBar:SetOrientation"HORIZONTAL"

        object.otherHealPredictionBar:SetPoint("TOPLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.otherHealPredictionBar:SetPoint("BOTTOMLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        object.otherHealPredictionBar:SetSize(ns.db.width, 0)
        object.otherHealPredictionBar:SetOrientation"HORIZONTAL"
    end

    object.myHealPredictionBar:GetStatusBarTexture():SetTexture(ns.db.myhealcolor.r, ns.db.myhealcolor.g, ns.db.myhealcolor.b, ns.db.myhealcolor.a)
    object.otherHealPredictionBar:GetStatusBarTexture():SetTexture(ns.db.otherhealcolor.r, ns.db.otherhealcolor.g, ns.db.otherhealcolor.b, ns.db.otherhealcolor.a)
end

local lockprint,updateFrameSet,updateObject,ApplyClickSet

local function CheckCombat ()
	if(InCombatLockdown()) then
			ns:RegisterEvent("PLAYER_REGEN_ENABLED")
			if not lockprint then
				lockprint = true
				print("当前处于战斗状态,将在脱离战斗后生效.")
				return true
			end
	else
		return false
	end
end

function ns.updateObjects()
	updateObject = CheckCombat ()
	if updateObject then return end
	
    for _, object in next, ns._Objects do
        object:SetSize(ns.db.width, ns.db.height)
        object:SetScale(ns.db.scale)

        ns:UpdateHealth(object.Health)
        ns:UpdatePower(object.Power)
        if UnitExists(object.unit) then
            object.Health:ForceUpdate()
            object.Power:ForceUpdate()
        end
        updateFonts(object)
        updateIndicators(object)
        updateIcons(object)
        updateHealbar(object)
        ns:UpdateName(object.Name, object.unit)

        if ns.db.smooth then
            object:EnableElement('freebSmooth')
        else
            object:DisableElement('freebSmooth')
        end
    end

    _G["oUF_FreebgridRaidFrame"]:SetSize(ns.db.width, ns.db.height)
    _G["oUF_FreebgridPetFrame"]:SetSize(ns.db.width, ns.db.height)
    _G["oUF_FreebgridMTFrame"]:SetSize(ns.db.width, ns.db.height)
	
end

function ns.updateFrameSetting()
	updateFrameSet = CheckCombat ()
	if updateFrameSet then return end
	
	if ns.db.multi then
		local headers = ns._Headers
		local i = 1
		for k, v in pairs( headers ) do
			local raidframe = string.match(k,"Raid_Freebgrid")
			if raidframe then	
				headers[k] :SetAttribute( 'showPlayer', ns.db.player)
				--headers[k] :SetAttribute( 'showSolo', ns.db.showsolo)
				headers[k] :SetAttribute( 'showParty', ns.db.party)	
				headers[k] :SetAttribute( 'initial-width', ns.db.width)
				headers[k] :SetAttribute( 'initial-height', ns.db.height)
				headers[k] :SetAttribute(  'unitsPerColumn', ns.db.numUnits)	
				headers[k] :SetAttribute('oUF-initialConfigFunction', ([[self:SetWidth(%d); self:SetHeight(%d)]]):format(ns.db.width, ns.db.height))
				ns._Headers[raidframe..i]:SetAttribute("groupFilter", i <= ns.db.numCol and i or "")				

				i = i + 1
			end
		end
	end	
	ns.updateObjects()
end

function ns.ApplyClickSetting()
	ApplyClickSet = CheckCombat ()
	if ApplyClickSet then return end
	
	for _, object in next, ns._Objects do
		ns:RegisterClicks(object)
	end
	print("点击施法已经重新设置...")
end

function ns:PLAYER_REGEN_ENABLED()
	print("Delaying updates until combat ends")
    lockprint = nil
	if updateObject then ns.updateObjects(); updateObject = nil end
	if ApplyClickSet then ns.ApplyClickSetting(); ApplyClickSet = nil end
	if updateFrameSet then ns.updateFrameSetting(); updateFrameSet = nil end
	
    ns:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

local SM = LibStub("LibSharedMedia-3.0", true)
local fonts = SM:List("font")
local statusbars = SM:List("statusbar")

local generalopts = {
    type = "group", name = "样式设定", order = 1,
    args = {
        scale = {
            name = "缩放",
            type = "range",
            order = 1,
            min = 0.5,
            max = 2.0,
            step = .1,
            get = function(info) return ns.db.scale end,
            set = function(info,val) ns.db.scale = val; ns.updateObjects() end,
        },
        width = {
            name = "宽度",
            type = "range",
            order = 2,
            min = 20,
            max = 150,
            step = 1,
            get = function(info) return ns.db.width end,
            set = function(info,val) ns.db.width = val; wipe(ns.nameCache); ns.updateObjects() end,
        },
        height = {
            name = "高度",
            type = "range",
            order = 3,
            min = 20,
            max = 150,
            step = 1,
            get = function(info) return ns.db.height end,
            set = function(info,val) ns.db.height = val;ns.updateObjects() end,
        },
        spacing = {
            name = "间距",
            type = "range",
            order = 4,
            min = 0,
            max = 30,
            step = 1,
            get = function(info) return ns.db.spacing end,
            set = function(info,val) ns.db.spacing = val;  ns.updateObjects();end,
        }, 
        raid = {
            name = "团队",
            type = "group",
            order = 5,
            inline = true,
            args = {
                horizontal = {
                    name = "小队单位水平排列",
                    type = "toggle",
                    order = 1,
					desc = "设置小队为横向或者竖向显示.",
                    get = function(info) return ns.db.horizontal end,
                    set = function(info,val)
                        if(val == true and (ns.db.growth ~= "UP" or ns.db.growth ~= "DOWN")) then
                            ns.db.growth = "UP"
                        elseif(val == false and (ns.db.growth ~= "RIGHT" or ns.db.growth ~= "LEFT")) then
                            ns.db.growth = "RIGHT"
                        end
                        ns.db.horizontal = val; 
						 ns.updateObjects();
                    end,
                },
                growth = {
                    name = "小队增长方向",
                    type = "select",
                    order = 2,
					desc = "设置团队中小队的排列增长方向.",
                    values = function(info,val) 
                        info = ns.db.growth
                        if not ns.db.horizontal then
                            return { ["LEFT"] = "左", ["RIGHT"] = "右" }
                        else
                            return { ["UP"] = "上", ["DOWN"] = "下" }
                        end
                    end,
                    get = function(info) return ns.db.growth end,
                    set = function(info,val) ns.db.growth = val; ns.updateObjects(); end,
                },
                groups = {
                    name = "队伍数量",
                    type = "range",
                    order = 3,
                    min = 1,
                    max = 8,
                    step = 1,
					desc = "设置团队中最大显示小队数量.",
                    get = function(info) return ns.db.numCol end,
                    set = function(info,val) ns.db.numCol = val;  ns.updateFrameSetting();end,
                },
                multi = {
                    name = "按小队排列",
                    type = "toggle",
                    desc = "按暴雪的团队排列方式排列小队.",
                    order = 5,
                    get = function(info) return ns.db.multi end,
                    set = function(info,val) ns.db.multi = val 
                        if val == true then
                            ns.db.sortClass = false
							ns.db.numUnits = 5
                        --    ns.db.sortName = false
                        end
                    end,
                },
                units = {
                    name = "每队伍单位数",
                    type = "range",
                    order = 4,
                    min = 1,
                    max = 40,
                    step = 1,
                    disabled = function(info) 
                        if ns.db.multi then return true end 
                    end,
                    get = function(info) return ns.db.numUnits end,
                    set = function(info,val) ns.db.numUnits = val; end,
                },
                sortClass = {
                    name = "按职业排列",
                    type = "toggle",
                    order = 7,
                    get = function(info) return ns.db.sortClass end,
                    set = function(info,val) ns.db.sortClass = val
                        if val == true then
                            ns.db.multi = false
                        end
                    end,
                },
                classOrder = {
                    name = "职业顺序",
                    type = "input",
                    desc = "Uppercase English class names separated by a comma. \n { CLASS[,CLASS]... }",
                    order = 8,
                    disabled = function() if not ns.db.sortClass then return true end end,
                    get = function(info) return ns.db.classOrder end,
                    set = function(info,val) ns.db.classOrder = tostring(val) end,
                },
                resetClassOrder = {
                    name = "重置职业顺序",
                    type = "execute",
                    order = 9,
                    disabled = function() if not ns.db.sortClass then return true end end,
                    func = function() ns.db.classOrder = ns.defaults.classOrder end,
                },
            },
        },
        pets = {
            name = "宠物",
            type = "group",
            order = 11,
            inline = true,
            args = {
                pethorizontal = {
                    name = "小队单位水平排列",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.pethorizontal end,
                    set = function(info,val)
                        if(val == true and (ns.db.petgrowth ~= "UP" or ns.db.petgrowth ~= "DOWN")) then
                            ns.db.petgrowth = "UP"
                        elseif(val == false and (ns.db.petgrowth ~= "RIGHT" or ns.db.petgrowth ~= "LEFT")) then
                            ns.db.petgrowth = "RIGHT"
                        end
                        ns.db.pethorizontal = val; 
                    end,
                },
                petgrowth = {
                    name = "增长方向",
                    type = "select",
                    order = 2,
                    values = function(info,val) 
                        info = ns.db.petgrowth
                        if not ns.db.pethorizontal then
                            return { ["LEFT"] = "左", ["RIGHT"] = "右" }
                        else
                            return { ["UP"] = "上", ["DOWN"] = "下" }
                        end
                    end,
                    get = function(info) return ns.db.petgrowth end,
                    set = function(info,val) ns.db.petgrowth = val; end,
                },
                petunits = {
                    name = "每队伍单位数",
                    type = "range",
                    order = 3,
                    min = 1,
                    max = 40,
                    step = 1,
                    get = function(info) return ns.db.petUnits end,
                    set = function(info,val) ns.db.petUnits = val; end,
                },
            },
        },
        MT = {
            name = "主坦克",
            type = "group",
            inline = true,
            order = 16,
            args= {
                MThorizontal = {
                    name = "小队单位水平排列",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.MThorizontal end,
                    set = function(info,val)
                        if(val == true and (ns.db.MTgrowth ~= "UP" or ns.db.MTgrowth ~= "DOWN")) then
                            ns.db.MTgrowth = "UP"
                        elseif(val == false and (ns.db.MTgrowth ~= "RIGHT" or ns.db.MTgrowth ~= "LEFT")) then
                            ns.db.MTgrowth = "RIGHT"
                        end
                        ns.db.MThorizontal = val; 
                    end,
                },
                MTgrowth = {
                    name = "增长方向",
                    type = "select",
                    order = 2,
                    values = function(info,val) 
                        info = ns.db.MTgrowth
                        if not ns.db.MThorizontal then
                            return { ["LEFT"] = "左", ["RIGHT"] = "右" }
                        else
                            return { ["UP"] = "上", ["DOWN"] = "下" }
                        end
                    end,
                    get = function(info) return ns.db.MTgrowth end,
                    set = function(info,val) ns.db.MTgrowth = val; end,
                },
                MTunits = {
                    name = "每队伍单位数",
                    type = "range",
                    order = 3,
                    min = 1,
                    max = 40,
                    step = 1,
                    get = function(info) return ns.db.MTUnits end,
                    set = function(info,val) ns.db.MTUnits = val; end,
                },
            },
        },
    },
}

local statusbaropts = {
    type = "group", name = "状态条", order = 2,
    args = {
        statusbar = {
            name = "状态条",
            type = "select",
            order = 1,
            itemControl = "DDI-Statusbar",
            values = statusbars,
            get = function(info) 
                for i, v in next, statusbars do
                    if v == ns.db.texture then return i end
                end
            end,
            set = function(info, val) ns.db.texture = statusbars[val]; 
                ns.db.texturePath = SM:Fetch("statusbar",statusbars[val]); 
                ns.updateObjects() 
            end,
        },
        orientation = {
            name = "生命条显示方向",
            type = "select",
            order = 2,
            values = ns.orientation,
            get = function(info) return ns.db.orientation end,
            set = function(info,val) ns.db.orientation = val; ns.updateObjects() end,
        },
        powerbar = {
            name = "法力条",
            type = "group",
            order = 2,
            inline = true,
            args = {
                power = {
                    name = "启用法力条",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.powerbar end,
                    set = function(info,val) ns.db.powerbar = val; ns.updateObjects() end,
                },
		onlymana = {
                    name = "只显示有蓝职业",
                    type = "toggle",
                    order = 2,
					disabled = function(info) if not ns.db.powerbar then return true end end,
                    get = function(info) return ns.db.onlymana end,
                    set = function(info,val) ns.db.onlymana = val; ns.updateObjects() end,
                },
		lowmana = {
                    name = "高亮显示低法力单位边框",
                    type = "toggle",
                    order = 3,
					disabled = function(info) if not ns.db.powerbar then return true end end,
                    get = function(info) return ns.db.lowmana end,
                    set = function(info,val) ns.db.lowmana = val; end,
                },
		percent = {
					name = "法力值阈值",
					type = "range",
					order = 4,
					min = 10,
					max = 100,
					step = 1,
					desc = "当有蓝职业法力值低于设定阈值百分比时高亮边框显示.",
					disabled = function(info) if not ns.db.powerbar then return true end end,
					get = function(info) return ns.db.manapercent end,
					set = function(info,val) ns.db.manapercent = val; end,
			
		},
        porientation = {
                    name = "法力条方向",
                    type = "select",
                    order = 5,
					disabled = function(info) if not ns.db.powerbar then return true end end,
                    values = ns.orientation,
                    get = function(info) return ns.db.porientation end,
                    set = function(info,val) ns.db.porientation = val; ns.updateObjects() end,
                },
		psize = {
                    name = "法力条尺寸",
                    type = "range",
                    order = 6,
                    min = .02,
                    max = .30,
                    step = .02,
					disabled = function(info) if not ns.db.powerbar then return true end end,
                    get = function(info) return ns.db.powerbarsize end,
                    set = function(info,val) ns.db.powerbarsize = val; ns.updateObjects() end,
                },
            },
        },
        altpower = {
					name = "能量值",
					type = "group",
					order = 3,
					inline = true,
					args = {
					text = {
                    name = "能量值文字",
                    type = "toggle",
                    order = 1,
					desc = "显示能量值,比如音波龙,古加尔等boss.",
                    get = function(info) return ns.db.altpower end,
                    set = function(info,val) ns.db.altpower = val end,
                },
            },
        },
    },
}

local fontopts = {
    type = "group", name = "字体", order = 3,
    args = {
        font = {
            name = "字体",
            type = "select",
            order = 1,
            itemControl = "DDI-Font",
            values = fonts,
            get = function(info)
                for i, v in next, fonts do
                    if v == ns.db.font then return i end		    
                end
            end,
            set = function(info, val) ns.db.font = fonts[val];
                ns.db.fontPath = SM:Fetch("font",fonts[val]);
                wipe(ns.nameCache); ns.updateObjects() 
            end,
        },
        outline = {
            name = "字体轮廓",
            type = "select",
            order = 2,
            values = ns.outline,
            get = function(info) 
                if not ns.db.outline then
                    return "None"
                else
                    return ns.db.outline
                end
            end,
            set = function(info,val) 
                if val == "None" then
                    ns.db.outline = "NONE"
                else
                    ns.db.outline = val					
                end
                ns.updateObjects()
            end,
        },
        fontsize = {
            name = "姓名字体尺寸",
            type = "range",
            order = 3,
	    desc = "调整单位姓名的字体大小",
            min = 8,
            max = 32,
            step = 1,
            get = function(info) return ns.db.fontsize end,
            set = function(info,val) ns.db.fontsize = val; wipe(ns.nameCache);  ns.updateObjects() end,
        },
        fontsizeEdge = {
            name = "指示器字体尺寸",
            type = "range",
            order = 4,
            desc = "调整上下指示器显示的字体大小",
            min = 8,
            max = 32,
            step = 1,
            get = function(info) return ns.db.fontsizeEdge  end,
            set = function(info,val) ns.db.fontsizeEdge = val; wipe(ns.nameCache);  ns.updateObjects() end,
        },
    },
}

local rangeopts = {
    type = "group", name = "距离", order = 4,
    args = {
        oor = {
            name = "超出距离淡出",
            type = "range",
            order = 1,
            min = 0,
            max = 1,
            step = .1,
            get = function(info) return ns.db.outsideRange end,
            set = function(info,val) ns.db.outsideRange = val end,
        },
        arrow = {
            name = "启用箭头方向指示",
            type = "toggle",
            order = 2,
	    desc = "使用一个箭头图标以指示同一地区内超出距离的单位的方向.",
            get = function(info) return ns.db.arrow end,
            set = function(info,val) ns.db.arrow = val
	    if val == false then
		ns.db.arrowmouseover = false
	    end	    
	    end,
        },
	scale = {
            name = "缩放",
            type = "range",
            order = 3,
            min = 0.5,
            max = 2.0,
            step = 0.5,
	    desc = "调整箭头缩放尺寸.",
            get = function(info) return ns.db.arrowscale end,
            set = function(info,val) ns.db.arrowscale = val; ns.updateObjects() end,
        },
        mouseover = {
            name = "只在鼠标悬停时显示",
            type = "toggle",
            order = 4,
            disabled = function(info) if not ns.db.arrow then return true end end,
            get = function(info) return ns.db.arrowmouseover end,
            set = function(info,val) ns.db.arrowmouseover = val end,
        },
	IsNotConnected = {
            name = "离线单位淡出显示",
            type = "toggle",
            order = 5,
            get = function(info) return ns.db.rangeIsNotConnected end,
            set = function(info,val) ns.db.rangeIsNotConnected = val end,
        },
    },
}

local healopts = {
    type = "group", name = "治疗预估", order = 5,
    args = {
        healtext = {
            type = "group",
            name = "治疗文字",
            order = 1,
            inline = true,
            args = {
                text = {
                    name = "接受治疗文字",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.healtext end,
                    set = function(info,val) ns.db.healtext= val end,
                },
            },
        },
        healbar = {
            type = "group",
            name = "生命条",
            order = 2,
            inline = true,
            args = {
                bar = {
                    name = "接受生命条",
                    type = "toggle",
                    order = 2,
                    get = function(info) return ns.db.healbar end,
                    set = function(info,val) ns.db.healbar = val end,
                },
                myheal = {
                    name = "我的治疗颜色",
                    type = "color",
                    order = 3,
                    hasAlpha = true,
                    get = function(info) return ns.db.myhealcolor.r, ns.db.myhealcolor.g, ns.db.myhealcolor.b, ns.db.myhealcolor.a  end,
                    set = function(info,r,g,b,a) ns.db.myhealcolor.r, ns.db.myhealcolor.g, ns.db.myhealcolor.b, ns.db.myhealcolor.a = r,g,b,a;
                        ns.updateObjects(); 
                    end,
                },
                otherheal = {
                    name = "其他单位治疗颜色",
                    type = "color",
                    order = 4,
                    hasAlpha = true,
                    get = function(info) return ns.db.otherhealcolor.r, ns.db.otherhealcolor.g, ns.db.otherhealcolor.b, ns.db.otherhealcolor.a  end,
                    set = function(info,r,g,b,a) ns.db.otherhealcolor.r, ns.db.otherhealcolor.g, ns.db.otherhealcolor.b, ns.db.otherhealcolor.a = r,g,b,a;
                        ns.updateObjects(); 
                    end,
                },
                overflow = {
                    name = "过量治疗",
                    type = "toggle",
                    order = 6,
                    get = function(info) return ns.db.healoverflow end,
                    set = function(info,val) ns.db.healoverflow = val end,
                },
                others = {
                    name = "只显示其他单位治疗",
                    type = "toggle",
                    order = 7,
                    get = function(info) return ns.db.healothersonly end,
                    set = function(info,val) ns.db.healothersonly = val end,
                }, 
            },
        },

			hptext = {
				type = "group",
				name = "生命文字",
				order = 8,
				inline = true,
				args = {
					text = {
						name = "生命之文字显示方式",
						type = "select",
						order = 1,
						get = function(info) return ns.db.hptext end,
						set = function(info,val) ns.db.hptext = val;  end,
						values =  hptext,
					},
				percent = {
					name = "生命值显示阈值",
					type = "range",
					order = 4,
					min = 10,
					max = 100,
					step = 1,
					desc = "当生命值低于设定阈值百分比时才显示.",
					get = function(info) return ns.db.hppercent end,
					set = function(info,val) ns.db.hppercent = val; ns.updateObjects() end,		
				},
			},
		},
    },
}

local miscopts = {
    type = "group", name = "一般设置", order = 6,
    args = {
		hideraid = {
            name = "关闭wow自带团队框架",
            type = "toggle",
            order = 1,
			desc = "关闭/显示wow自带团队框架,不可在战斗中使用,重启生效.",
            get = function(info) return ns.db.hideblzraid end,
            set = function(info,val) ns.db.hideblzraid = val;end,
        },
        party = {
            name = "小队时显示",
            type = "toggle",
            order = 2,
            get = function(info) return ns.db.party end,
            set = function(info,val) ns.db.party = val;  ns.updateObjects();end,
        },
        solo = {
            name = "solo时显示",
            type = "toggle",
            order = 3,
            get = function(info) return ns.db.solo end,
            set = function(info,val) ns.db.solo = val;  ns.updateObjects();end,
        },
        player = {
            name = "队伍中显示自己",
            type = "toggle",
            order = 4,
            get = function(info) return ns.db.player end,
            set = function(info,val) ns.db.player = val;  ns.updateObjects();end,
        },
        pets = {
            name = "显示队伍/团队宠物",
            type = "toggle",
            order = 5,
            get = function(info) return ns.db.pets end,
            set = function(info,val) ns.db.pets = val end,
        },
        MT = {
            name = "主坦克",
            type = "toggle",
            order = 6,
            get = function(info) return ns.db.MT end,
            set = function(info,val) ns.db.MT = val end,
        },
        GCD = {
            name = "显示GCD条",
            type = "toggle",
            order = 7,    
			desc = "在鼠标所在的单位上以透明的条显示GCD状态.",
            get = function(info) return ns.db.GCD end,
            set = function(info,val) ns.db.GCD = val end,
        },
		GCDchange = {
            name = "非治疗职业不显示GCD条",
            type = "toggle",
            order = 8,  
			disabled = function(info) if not ns.db.GCD then return true end end,
            get = function(info) return ns.db.GCDChange end,
            set = function(info,val) ns.db.GCDChange = val end,
        },
        role = {
            name = "角色类型图标",
            type = "toggle",
            order = 9,
            get = function(info) return ns.db.roleicon end,
            set = function(info,val) ns.db.roleicon = val end,
        },
        fborder = {
            name = "高亮目标或焦点边框",
            type = "toggle",
            order = 10,
            get = function(info) return ns.db.fborder end,
            set = function(info,val) ns.db.fborder = val end,
        },
        afk = {
            name = "AFK 标记/计时",
            type = "toggle",
            order = 11,
            get = function(info) return ns.db.afk end,
            set = function(info,val) ns.db.afk = val end,
        },
        highlight = {
            name = "鼠标悬停高亮",
            type = "toggle",
            order = 12,
            get = function(info) return ns.db.highlight end,
            set = function(info,val) ns.db.highlight = val end,
        },
       
        tooltip = {
            name = "战斗中隐藏提示信息",
            type = "toggle",
            order = 13,
			desc = "在战斗中隐藏鼠标提示信息.",
            get = function(info) return ns.db.tooltip end,
            set = function(info,val) ns.db.tooltip = val end,
        },
        smooth = {
            name = "平滑显示",
            type = "toggle",
            order = 14,
            get = function(info) return ns.db.smooth end,
            set = function(info,val) ns.db.smooth = val; ns.updateObjects() end,
        },
        hidemenu = {
            name = "战斗中隐藏右键菜单",
            type = "toggle",
            order = 15,
            desc = "在战斗中不显示右键菜单.",
            get = function(info) return ns.db.hidemenu end,
            set = function(info,val) ns.db.hidemenu = val; end,
        },
		res = {
            name = "复活通知",
            type = "toggle",
            order = 16,
            desc = "复活队友时聊天栏发出通知.只适合治疗职业",
            get = function(info) return ns.db.Resurrection end,
            set = function(info,val) ns.db.Resurrection = val; end,
        },
		tankaura = {
            name = "坦克技能监视",
            type = "toggle",
            order = 17,
            desc = "图标方式显示坦克的减伤技能.该技能的显示优先级最低.",
            get = function(info) return ns.db.tankaura end,
            set = function(info,val) ns.db.tankaura = val; end,
        },

		dispel = {
            name = "可驱散buff显示方式",
            type = "select",
            order = 19,
            values = dispeltext,
            get = function(info) return ns.db.dispel end,
            set = function(info,val) ns.db.dispel = val end,
        },
        indicator = {
            name = "指示器尺寸",
            type = "range",
            order = 20,
            min = 4,
            max = 20,
            step = 1,
            get = function(info) return ns.db.indicatorsize end,
            set = function(info,val) ns.db.indicatorsize = val; ns.updateObjects() end,
        },
        symbol = {
            name = "右下指示器尺寸",
            type = "range",
            order = 21,
            min = 8,
            max = 20,
            step = 1,
            get = function(info) return ns.db.symbolsize end,
            set = function(info,val) ns.db.symbolsize = val; ns.updateObjects() end,
        },
        icon = {
            name = "队长,角色类型等图标尺寸",
            type = "range",
            order = 22,
            min = 8,
            max = 20,
            step = 1,
            get = function(info) return ns.db.leadersize end,
            set = function(info,val) ns.db.leadersize = val; ns.updateObjects() end,
        },
        aura = {
            name = "光环尺寸",
            type = "range",
            order = 23,
            min = 8,
            max = 30,
            step = 1,
            get = function(info) return ns.db.aurasize end,
            set = function(info,val) ns.db.aurasize = val; ns.updateObjects() end,
        },
    },
}

local coloropts = {
    type = "group", name = "颜色", order = 7,
    args = {
        HP = {
            name = "生命条",
            type = "group",
            order = 1,
            inline = true,
            args = {
                reverse = {
                    name = "按职业颜色显示",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.reversecolors end,
                    set = function(info,val) ns.db.reversecolors = val;
					if ns.db.definecolors and val == true then
						ns.db.definecolors = false
					end
					ns:Colors(); ns.updateObjects();
                    end,
                },
                hpdefine = {
                    type = "group",
                    name = "自定义生命条颜色",
                    order = 2,
                    inline = true,
                    args = {
                        definecolors = {
                            name = "自定义生命条颜色",
                            type = "toggle",
                            order = 2,
                            get = function(info) return ns.db.definecolors end,
                            set = function(info,val) ns.db.definecolors = val;
							if ns.db.reversecolors and val == true then
								ns.db.reversecolors = false
							end
                            ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                        hpcolor = {
                            name = "生命条颜色",
                            type = "color",
                            order = 3,
                            hasAlpha = false,
							disabled = function(info) return not ns.db.definecolors end,
                            get = function(info) return ns.db.hpcolor.r, ns.db.hpcolor.g, ns.db.hpcolor.b, ns.db.hpcolor.a end,
                            set = function(info,r,g,b,a) ns.db.hpcolor.r, ns.db.hpcolor.g, ns.db.hpcolor.b, ns.db.hpcolor.a = r,g,b,a;
                                ns:Colors();ns.updateObjects(); 
                            end,
                        },
						classbgcolor = {
                            name = "背景以职业颜色显示",
                            type = "toggle",
                            order = 4,
							disabled = function(info) return not ns.db.definecolors end,
                            get = function(info) return ns.db.classbgcolor end,
                            set = function(info,val) ns.db.classbgcolor = val;
							if ns.db.reversecolors and val == true then
								ns.db.reversecolors = false
							end
                            ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                        hpbgcolor = {
                            name = "生命条背景色",
                            type = "color",
                            order = 5,
                            hasAlpha = false,
							disabled = function(info) return not ns.db.definecolors or  ns.db.classbgcolor end,
                            get = function(info) return ns.db.hpbgcolor.r, ns.db.hpbgcolor.g, ns.db.hpbgcolor.b, ns.db.hpbgcolor.a end,
                            set = function(info,r,g,b,a) ns.db.hpbgcolor.r, ns.db.hpbgcolor.g, ns.db.hpbgcolor.b, ns.db.hpbgcolor.a = r,g,b,a;
                                ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                        colorSmooth = {
                            name = "平滑梯度显示",
                            type = "toggle",
                            order = 6,
                            disabled = function(info) return not ns.db.definecolors end,
                            get = function(info) return ns.db.colorSmooth end,
                            set = function(info,val) ns.db.colorSmooth = val;
                                ns.updateObjects(); 
                            end,
                        },
                        gradient = {
                            name = "低生命值颜色",
                            type = "color",
                            order = 7,
                            hasAlpha = false,
							disabled = function(info) return not ns.db.definecolors end,
                            get = function(info) return ns.db.gradient.r, ns.db.gradient.g, ns.db.gradient.b, ns.db.gradient.a end,
                            set = function(info,r,g,b,a) ns.db.gradient.r, ns.db.gradient.g, ns.db.gradient.b, ns.db.gradient.a = r,g,b,a;
                                ns.updateObjects(); 
                            end,
                        },
                    },
                },
            },
        },
        PP = {
            name = "法力条",
            type = "group",
            order = 2,
            inline = true,
            args = {
                powerclass = {
                    name = "以职业颜色显示",
                    type = "toggle",
                    order = 1,
                    get = function(info) return ns.db.powerclass end,
                    set = function(info,val) ns.db.powerclass = val;
                        if ns.db.powerdefinecolors and val == true then
                            ns.db.powerdefinecolors = false
                        end
                        ns:Colors(); ns.updateObjects();
                    end,
                },
                ppdefine = {
                    type = "group",
                    name = "自定义法力条颜色",
                    order = 2,
                    inline = true,
                    args = {
                        powerdefinecolors = {
                            name = "自定义法力条颜色",
                            type = "toggle",
                            order = 2,
                            get = function(info) return ns.db.powerdefinecolors end,
                            set = function(info,val) ns.db.powerdefinecolors = val;
                                if ns.db.powerclass and val == true then
                                    ns.db.powerclass = false
                                end
                                ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                        powercolor = {
                            name = "法力条颜色",
                            type = "color",
                            order = 3,
                            hasAlpha = false,
							disabled = function(info) return ns.db.powerclass end,
                            get = function(info) return ns.db.powercolor.r, ns.db.powercolor.g, ns.db.powercolor.b, ns.db.powercolor.a end,
                            set = function(info,r,g,b,a) ns.db.powercolor.r, ns.db.powercolor.g, ns.db.powercolor.b, ns.db.powercolor.a = r,g,b,a; 
                                ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                        powerbgcolor = {
                            name = "法力条背景色",
                            type = "color",
                            order = 4,
                            hasAlpha = false,
							disabled = function(info) return ns.db.powerclass end,
                            get = function(info) return ns.db.powerbgcolor.r, ns.db.powerbgcolor.g, ns.db.powerbgcolor.b, ns.db.powerbgcolor.a end,
                            set = function(info,r,g,b,a) ns.db.powerbgcolor.r, ns.db.powerbgcolor.g, ns.db.powerbgcolor.b, ns.db.powerbgcolor.a = r,g,b,a;
                                ns:Colors(); ns.updateObjects(); 
                            end,
                        },
                    },
                },
            },
        },
		other = {
            name = "其他",
            type = "group",
            order = 3,
            inline = true,
            args = {
				vehiclecolor = {
				name = "载具颜色",
				type = "color",
				order = 1,
				hasAlpha = false,
				desc = "单位在载具时颜色.",
				get = function(info) return ns.db.vehiclecolor.r, ns.db.vehiclecolor.g, ns.db.vehiclecolor.b, ns.db.vehiclecolor.a end,
				set = function(info,r,g,b,a) ns.db.vehiclecolor.r, ns.db.vehiclecolor.g, ns.db.vehiclecolor.b, ns.db.vehiclecolor.a = r,g,b,a;
					ns:Colors(); ns.updateObjects(); 
				end,
				},
				enemycolor = {
				name = "敌对颜色",
				type = "color",
				order = 2,
				hasAlpha = false,
				desc = "单位处于敌对状态时颜色,如被心控等.",
				get = function(info) return ns.db.enemycolor.r, ns.db.enemycolor.g, ns.db.enemycolor.b, ns.db.enemycolor.a end,
				set = function(info,r,g,b,a) ns.db.enemycolor.r, ns.db.enemycolor.g, ns.db.enemycolor.b, ns.db.enemycolor.a = r,g,b,a;
					ns:Colors(); ns.updateObjects(); 
				end,
				},
				deadcolor = {
				name = "死亡颜色",
				type = "color",
				order = 3,
				hasAlpha = false,
				desc = "单位处于死亡或幽灵状态时颜色.",
				get = function(info) return ns.db.deadcolor.r, ns.db.deadcolor.g, ns.db.deadcolor.b, ns.db.deadcolor.a end,
				set = function(info,r,g,b,a) ns.db.deadcolor.r, ns.db.deadcolor.g, ns.db.deadcolor.b, ns.db.deadcolor.a = r,g,b,a;
					ns:Colors(); ns.updateObjects(); 
				end,
				},
			},
		},
		
    },
}


local ClickCastSets = {
    type = "group",
	name = "点击施法", 
	order = 8, 
	childGroups = "select",
	args = {
		Enable = {
			name = "启用",
			type = "toggle",
			order = 1,
			width  = "full",
			desc = "启用点击施法,可以在下面设置相关技能和按键绑定.",
			get = function(info) return ns.db.ClickCastenable end,
			set = function(info,val) ns.db.ClickCastenable = val;end,
			},
		SetDefault = {
				name = "恢复默认",
				type = "execute",
				func = function() ns:ClickSetDefault();ns.db.ClickCastsetchange = true; ns.ApplyClickSetting(); end,
				order = 2,
			desc = "恢复点击施法设置为默认.",
			},
		apply = {
				name = "应用更改",
				type = "execute",
				func = function() ns.db.ClickCastsetchange = true; ns.ApplyClickSetting(); end,
				order = 3,
			desc = "应用当前按键设定.",
			},

		CSGroup1 = {
			order = 4,
			type = "group",
			name = "鼠标左键",		
			disabled = function() return not ns.db.ClickCastenable end,
			args = {
				type1 = {
					order = 1,
					type = "select",
					name = "鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["Click"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","Click","鼠标左键");  end,
					values = defaultvalues
				},
				shiftztype1 = {
					order = 2,
					type = "select",
					name = "shift + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","shift-","shift + 鼠标左键");  end,
					values = defaultvalues						
				},
				ctrlztype1 = {
					order = 3,
					type = "select",
					name = "ctrl + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","ctrl-", "ctrl + 鼠标左键");  end,
					values = defaultvalues
				},
				altztype1 = {
					order = 4,
					type = "select",
					name = "alt + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["alt-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","alt-","alt + 鼠标左键");  end,
					values = defaultvalues
				},
				altzctrlztype1 = {
					order = 5,
					type = "select",
					name = "alt + ctrl + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["alt-ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","alt-ctrl-", "alt + ctrl + 鼠标左键");  end,
					values = defaultvalues
				},
				altzshiftztype1 = {
					order = 6,
					type = "select",
					name = "alt + shift + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["alt-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","alt-shift-","alt + shift + 鼠标左键");  end,
					values = defaultvalues
				},
				ctrlzshifttype1 = {
					order = 7,
					type = "select",
					name = "ctrl + shift + 鼠标左键",
					get = function(info) return ns.db.ClickCastset["1"]["ctrl-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"1","ctrl-shift-","ctrl + shift + 鼠标左键");  end,
					values = defaultvalues
				},
			},
		},
		CSGroup2 = {
			order = 5,
			type = "group",
			name = "鼠标右键",
			
			disabled = function() return not ns.db.ClickCastenable end,	
			args = {
				type2 = {
					order = 1,
					type = "select",
					name = "鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["Click"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","Click","鼠标右键");  end,
					values = defaultvalues
				},
				shiftztype2 = {
					order = 2,
					type = "select",
					name = "shift + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","shift-","shift + 鼠标右键");  end,
					values = defaultvalues				
				},
				ctrlztype2 = {
					order = 3,
					type = "select",
					name = "ctrl + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","ctrl-","ctrl + 鼠标右键");  end,
					values = defaultvalues
				},
				altztype2 = {
					order = 4,
					type = "select",
					name = "alt + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["alt-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","alt-","alt + 鼠标右键");  end,
					values = defaultvalues
				},
				altzctrlztype2 = {
					order = 5,
					type = "select",
					name = "alt + ctrl + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["alt-ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","alt-ctrl-","alt + ctrl + 鼠标右键");  end,
					values = defaultvalues
				},
				altzshiftztype2 = {
					order = 6,
					type = "select",
					name = "alt + shift + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["alt-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","alt-shift-","alt + shift + 鼠标右键");  end,
					values = defaultvalues
				},
				ctrlzshifttype2 = {
					order = 7,
					type = "select",
					name = "ctrl + shift + 鼠标右键",
					get = function(info) return ns.db.ClickCastset["2"]["ctrl-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"2","ctrl-shift-","ctrl + shift + 鼠标右键");  end,
					values = defaultvalues
				},
			},
		},

		CSGroup3 = {
			order = 6,
			type = "group",
			name = "鼠标中键",
			
			disabled = function() return not ns.db.ClickCastenable end,	
			args = {
				type3 = {
					order = 1,
					type = "select",
					name = "鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["Click"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","Click","鼠标中键");  end,
					values = defaultvalues
				},
				shiftztype3 = {
					order = 2,
					type = "select",
					name = "shift + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","shift-","shift + 鼠标中键");  end,
					values = defaultvalues					
				},
				ctrlztype3 = {
					order = 3,
					type = "select",
					name = "ctrl + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","ctrl-", "ctrl + 鼠标中键");  end,
					values = defaultvalues
				},
				altztype3 = {
					order = 4,
					type = "select",
					name = "alt + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["alt-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","alt-","alt + 鼠标中键");  end,
					values = defaultvalues
				},
				altzctrlztype3 = {
					order = 5,
					type = "select",
					name = "alt + ctrl + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["alt-ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","alt-ctrl-","alt + ctrl + 鼠标中键");  end,
					values = defaultvalues
				},
				altzshiftztype3 = {
					order = 6,
					type = "select",
					name = "alt + shift + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["alt-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","alt-shift-","alt + shift + 鼠标中键");  end,
					values = defaultvalues
				},
				ctrlzshifttype3 = {
					order = 7,
					type = "select",
					name = "ctrl + shift + 鼠标中键",
					get = function(info) return ns.db.ClickCastset["3"]["ctrl-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"3","ctrl-shift-", "ctrl + shift + 鼠标中键");  end,
					values = defaultvalues
				},
			},
		},
		CSGroup4 = {
			order = 7,
			type = "group",
			name = "鼠标4键",
			
			disabled = function() return not ns.db.ClickCastenable end,	
			args = {
				type4 = {
					order = 1,
					type = "select",
					name = "鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["Click"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","Click", "鼠标4键");  end,
					values = defaultvalues
				},
				shiftztype4 = {
					order = 2,
					type = "select",
					name = "shift + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","shift-","shift + 鼠标4键");  end,
					values = defaultvalues						
				},
				ctrlztype4 = {
					order = 3,
					type = "select",
					name = "ctrl + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","ctrl-","ctrl + 鼠标4键");  end,
					values = defaultvalues
				},
				altztype4 = {
					order = 4,
					type = "select",
					name = "alt + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["alt-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","alt-","alt + 鼠标4键");  end,
					values = defaultvalues
				},
				altzctrlztype4 = {
					order = 5,
					type = "select",
					name = "alt + ctrl + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["alt-ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","alt-ctrl-", "alt + ctrl + 鼠标4键");  end,
					values = defaultvalues
				},
				altzshiftztype4 = {
					order = 6,
					type = "select",
					name = "alt + shift + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["alt-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","alt-shift-","alt + shift + 鼠标4键");  end,
					values = defaultvalues
				},
				ctrlzshifttype4 = {
					order = 7,
					type = "select",
					name = "ctrl + shift + 鼠标4键",
					get = function(info) return ns.db.ClickCastset["4"]["ctrl-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"4","ctrl-shift-", "ctrl + shift + 鼠标4键");  end,
					values = defaultvalues
				},
			},
		},
		CSGroup5 = {
			order = 8,
			type = "group",
			name = "鼠标5键",
			
			disabled = function() return not ns.db.ClickCastenable end,	
			args = {
				type5 = {
					order = 1,
					type = "select",
					name = "鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["Click"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","Click","鼠标5键");  end,
					values = defaultvalues
				},
				shiftztype5 = {
					order = 2,
					type = "select",
					name = "shift + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","shift-","shift + 鼠标5键");  end,
					values = defaultvalues					
				},
				ctrlztype5 = {
					order = 3,
					type = "select",
					name = "ctrl + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","ctrl-","ctrl + 鼠标5键");  end,
					values = defaultvalues
				},
				altztype5 = {
					order = 4,
					type = "select",
					name = "alt + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["alt-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","alt-","alt + 鼠标5键");  end,
					values = defaultvalues
				},
				altzctrlztype5 = {
					order = 5,
					type = "select",
					name = "alt + ctrl + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["alt-ctrl-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","alt-ctrl-", "alt + ctrl + 鼠标5键");  end,
					values = defaultvalues
				},
				altzshiftztype5 = {
					order = 6,
					type = "select",
					name = "alt + shift + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["alt-shift-"]["action"] end,
					set = function(info,val) SetClickKeyvalue(val,"5","alt-shift-","alt + shift + 鼠标5键");  end,
					values = defaultvalues
				},
				ctrlzshifttype5 = {
					order = 7,
					type = "select",
					name = "ctrl + shift + 鼠标5键",
					get = function(info) return ns.db.ClickCastset["5"]["ctrl-shift-"]["action"]   end,
					set = function(info,val) SetClickKeyvalue(val,"5","ctrl-shift-","ctrl + shift + 鼠标5键");  end,
					values = defaultvalues
				},
			},
		},
		macro = {
					order = 9,
					type = "input",
					width  = "full",
					multiline  = true,
					name = function(info)return macroedit.keyname.."  宏编辑窗口." end,		
					hidden =  function() return macroedit.hidden end,				
					desc = "注意:这只是一个简单的宏编辑窗口,不会检测你的宏的正确性,也不会改变当前目标,所以请使用@mouseover条件方式让你的法术对点击的目标使用.如:'/cast [@mouseover,help,nodead,exists]强效治疗波'.",
					get = function(info) if  macroedit.path then return macroedit.path["macrotext"] else return "" end end,
					set = function(info,val) 
						macroedit.path["macrotext"] = val
						macroedit.hidden = true
					end,
		},
    },	
}

if ns.db.ClickCastenable then	
	local class = select(2, UnitClass("player"))
	for _, v in pairs(default_spells[class]) do
		local spellname = GetSpellInfo(v)	
		if spellname then
			for  i = 1, 5 do
				ClickCastSets["args"]["CSGroup"..i ]["args"]["type"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["shiftztype"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["ctrlztype"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["altztype"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["altzctrlztype"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["altzshiftztype"..i ]["values"][tostring(spellname)]  = spellname
				ClickCastSets["args"]["CSGroup"..i ]["args"]["ctrlzshifttype"..i ]["values"][tostring(spellname)]  = spellname
			end
		end
	end
end

local options = {
    type = "group", name = ADDON_NAME,
    args = {
        unlock = {
            name = "解锁锚点",
            type = "execute",
            func = function() ns:Movable(); end,
            order = 1,
        },
        reload = {
            name = "重载UI",
            type = "execute",
            desc = "多数的选项更改需要重载UI后才能生效.",
            func = function() ReloadUI(); end,
            order = 2,
        },
		default = {
            name = "恢复默认设置",
            type = "execute",
            desc = "还原所有设置为默认选项,可能需要重载UI以使设定生效.",
            func = function() 
				for k, v in pairs(ns.defaults) do
					ns.db[k] = v 
				end

				ns.db.ClickCastsetchange = true
				ns.ClickSetDefault()
				ns.ApplyClickSetting()
				ns.updateFrameSetting()
				ns.restoreDefaultPosition()
			end,
            order = 3,
        },
        general = generalopts,
        statusbar = statusbaropts,
        font = fontopts,
        range = rangeopts,
        heal = healopts,
        misc = miscopts,
        color = coloropts,
		ClickSet = ClickCastSets,
    },
}

	

local AceConfig = LibStub("AceConfig-3.0")
AceConfig:RegisterOptionsTable(ADDON_NAME, options)

local ACD = LibStub('AceConfigDialog-3.0')
ACD:AddToBlizOptions(ADDON_NAME, ADDON_NAME)

--InterfaceOptions_AddCategory(ns.movableopt)
LibStub("LibAboutPanel").new(ADDON_NAME, ADDON_NAME)
