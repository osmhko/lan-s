--print ("喵喵喵")
local cfg = {}
--------------------------------------------------------------------------------------
--CONFIG
--------------------------------------------------------------------------------------
cfg.font = "Fonts\\Zykai_T.ttf"
cfg.fontsize = 14
cfg.fontflag = nil
--cfg.bordersize = 1.2805
--cfg.shadowsize = 12
--------------------------------------------------------------------------------------
--CONFIG END
--------------------------------------------------------------------------------------
local class = select(2,UnitClass'player')
local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
--print (class..":"..classcolor.r..","..classcolor.g..","..classcolor.b)
local glow, blank, status = "Interface\\Addons\\Beauty\\media\\glowTex", "Interface\\Addons\\Beauty\\media\\blank", "Interface\\Addons\\Beauty\\media\\statusbar"

local load = CreateFrame("Frame")
load:RegisterEvent("PLAYER_ENTERING_WORLD")
load:SetScript("OnEvent", function() 
	cfg.bordersize = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/GetCVar("uiScale")
	cfg.shadowsize = (cfg.bordersize*math.floor(12/cfg.bordersize+.5))
--	print (GetCVar("uiScale"))
--	print (cfg.bordersize)
	local bottom = CreateFrame("Frame", "BottemInfoPanel", UIParent)
	bottom:SetFrameStrata("BACKGROUND")
	bottom:SetFrameLevel(1)
	bottom:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", -1, 18)
	bottom:SetPoint("BOTTOMRIGHT", UIParent, 1, -1)
	bottom:SetBackdrop({
			edgeFile = blank,
			bgFile = blank,
			edgeSize = cfg.bordersize,
	})
	bottom:SetBackdropBorderColor(0,0,0,1)--(classcolor.r, classcolor.g, classcolor.b, 1)
	bottom:SetBackdropColor(.2*classcolor.r, .2*classcolor.g, .2*classcolor.b, 0)

	bottom.bg = CreateFrame("Frame", "BottemInfoPanel", bottom)
	bottom.bg:SetFrameStrata("BACKGROUND")
	bottom.bg:SetAllPoints(bottom)
	bottom.bg:SetFrameLevel(0)
	bottom.gradient = bottom.bg:CreateTexture()
	bottom.gradient:SetTexture(blank)
	bottom.gradient:SetAllPoints(bottom)
	bottom.gradient:SetGradientAlpha("VERTICAL", .05, .05, .05, .3, .05, .05, .05, .8)

	bottom.shadow = CreateFrame("Frame", nil, bottom)
	bottom.shadow:SetPoint("TOPLEFT", -cfg.shadowsize, cfg.shadowsize)
	bottom.shadow:SetPoint("BOTTOMRIGHT", cfg.shadowsize, -cfg.shadowsize)
	bottom.shadow:SetBackdrop({
			edgeFile = glow,
			bgFile = "",
			edgeSize = cfg.shadowsize,
	})
	bottom.shadow:SetBackdropBorderColor(.05, .05, .05, .9)

	local top = CreateFrame("Frame", "TopInfoPanel", UIParent)
	top:SetFrameStrata("BACKGROUND")
	top:SetFrameLevel(1)
	top:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -1, -20)
	top:SetPoint("TOPRIGHT", UIParent, 1, 1)
	top:SetBackdrop({
			edgeFile = blank,
			bgFile = blank,
			edgeSize = cfg.bordersize,
	})
	top:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
	top:SetBackdropColor(.2*classcolor.r, .2*classcolor.g, .2*classcolor.b, 0)

	top.bg = CreateFrame("Frame", "TopInfoPanel", top)
	top.bg:SetFrameStrata("BACKGROUND")
	top.bg:SetAllPoints(top)
	top.bg:SetFrameLevel(0)
	top.gradient = top.bg:CreateTexture()
	top.gradient:SetTexture(blank)
	top.gradient:SetAllPoints(top)
	top.gradient:SetGradientAlpha("VERTICAL", .05, .05, .05, .8, .05, .05, .05, .3)

	top.shadow = CreateFrame("Frame", nil, top)
	top.shadow:SetPoint("TOPLEFT", -cfg.shadowsize, cfg.shadowsize)
	top.shadow:SetPoint("BOTTOMRIGHT", cfg.shadowsize, -cfg.shadowsize)
	top.shadow:SetBackdrop({
			edgeFile = glow,
			bgFile = "",
			edgeSize = cfg.shadowsize,
	})
	top.shadow:SetBackdropBorderColor(.05, .05, .05, .9)
end)

--[[
local bar = {}
for i = 1,7 do
	bar[i] = CreateFrame("Frame", "BottomInfoBar"..i, BottemInfoPanel)
	bar[i]:SetSize(80, 6)
	bar[i]:SetBackdrop({
		edgeFile = blank,
		bgFile = blank,
		edgeSize = cfg.bordersize,
})
	bar[i]:SetBackdropBorderColor(.05, .05, .05, .9)
	bar[i]:SetBackdropColor(0, 0, 0, 0)
	if i == 1 then
		bar[i]:SetPoint("BOTTOMRIGHT", BottemInfoPanel, "BOTTOMRIGHT", -5, 1)
	else
		bar[i]:SetPoint("RIGHT", bar[i-1], "LEFT", -5, 0)
	end
	bar[i].Status = CreateFrame("StatusBar", "BottomInfoBarStatus"..i, bar[i])
	bar[i].Status:Point("TOPLEFT", bar[i], "TOPLEFT", 1, -1)
	bar[i].Status:Point("BOTTOMRIGHT", bar[i], "BOTTOMRIGHT", -1, 1)
	bar[i].Status:SetStatusBarTexture(status)
	bar[i].Status:SetStatusBarColor(1, 1, .6)
	bar[i].Status:SetMinMaxValues(0, 100)
	bar[i].Status:SetValue(100)	
	
	bar[i].Text = bar[i].Status:CreateFontString(nil, "OVERLAY")
	bar[i].Text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
	bar[i].Text:SetPoint("BOTTOM", bar[i], "TOP", 0, 0)
	bar[i].Text:SetShadowColor(0, 0, 0, 0.4)
	bar[i].Text:SetShadowOffset(cfg.bordersize, -cfg.bordersize)
end
]]