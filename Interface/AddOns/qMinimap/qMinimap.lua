Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -10, -10)
Minimap:SetSize(150, 150)
Minimap:SetFrameLevel(5)

local dummy = function() end
local _G = getfenv(0)

local frames = {
    "GameTimeFrame",
    "MinimapBorderTop",
    "MinimapNorthTag",
    "MinimapBorder",
    "MinimapZoneTextButton",
    "MinimapZoomOut",
    "MinimapZoomIn",
    "MiniMapVoiceChatFrame",
    "MiniMapWorldMapButton",
    "MiniMapMailBorder",
	"GuildInstanceDifficulty",
    "MiniMapBattlefieldBorder",
}

for i in pairs(frames) do
    _G[frames[i]]:Hide()
    _G[frames[i]].Show = dummy
end
local shadows = {
	edgeFile = "Interface\\Addons\\qMinimap\\media\\glowTex", 
	edgeSize = 4,
	insets = { left = 1, right = 1, top = 1, bottom = 1 }
}
function CreateShadow(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateInnerBorder(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", nil, f)
	f.iborder:SetPoint("TOPLEFT", 1, -1)
	f.iborder:SetPoint("BOTTOMRIGHT", -1, 1)
	f.iborder:SetFrameLevel(f:GetFrameLevel())
	f.iborder:SetBackdrop({
	  edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	f.iborder:SetBackdropBorderColor(0, 0, 0)
	return f.iborder
end
function frame1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = -1, right = -1, top = -1, bottom = -1} 
	})
	f:SetBackdropColor(.06,.06,.06,1)
	f:SetBackdropBorderColor(.15,.15,.15,1)
CreateInnerBorder(f)	
end


MinimapCluster:EnableMouse(false)

--Tracking 追踪
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("BOTTOMRIGHT", Minimap, 0, 0)
MiniMapTracking:SetScale(.9)

--BG icon 微缩战场框架
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, 0, 0)

--LFG icon 随机
MiniMapLFGFrame:ClearAllPoints()
MiniMapLFGFrameBorder:SetAlpha(0)
MiniMapLFGFrame:SetPoint("BOTTOMLEFT", Minimap, 0, 0)

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 0, 0)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailIcon:SetTexture("Interface\\AddOns\\qMinimap\\media\\mail.tga")
MiniMapMailBorder:Hide()

---Hide Instance Difficulty flag 隐藏难度标志
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Hide()

-- Enable mouse scrolling 启用鼠标滚动
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)


-------------------------------------------------
local id = CreateFrame("Frame", nil, Minimap)
id:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 6, -8)
id:RegisterEvent("PLAYER_ENTERING_WORLD")
id:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
id:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
id:SetSize(10, 10)

local idtext = id:CreateFontString(nil, "OVERLAY")
idtext:SetPoint("LEFT", id)
idtext:SetJustifyH('LEFT')
idtext:SetTextColor(1, 0, 0)
idtext:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")

local function diff()
	local inInstance, instanceType = IsInInstance()
	local _, _, difficultyIndex, _, _, dynamicDifficulty, isDynamic = GetInstanceInfo()

	if inInstance and instanceType == "raid" then
		if (isDynamic and difficultyIndex == 1 and dynamicDifficulty == 0) or (not isDynamic and difficultyIndex == 1) then
			idtext:SetText("10")
		elseif (isDynamic and (difficultyIndex == 3 and dynamicDifficulty == 0) or (difficultyIndex == 1 and dynamicDifficulty == 1)) or (not isDynamic and difficultyIndex == 3) then
			idtext:SetText("10H")
		elseif (isDynamic and difficultyIndex == 2 and dynamicDifficulty == 0) or (not isDynamic and difficultyIndex == 2) then
			idtext:SetText("25")
		elseif (isDynamic and (difficultyIndex == 2 and dynamicDifficulty == 1) or (difficultyIndex == 4)) or (not isDynamic and difficultyIndex == 4) then
			idtext:SetText("25H")
		end
	elseif inInstance and instanceType == "party" then
		if difficultyIndex == 1 then
			idtext:SetText("5")
		elseif difficultyIndex == 2 then
			idtext:SetText("5H")
		end
	else
		idtext:SetText("")
	end
end
id:SetScript("OnEvent", diff)-----------
----------------------------------------------------------------------------------------
-- Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() ToggleTalentFrame() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = SLASH_CALENDAR1:gsub("/(.*)","%1"), 
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	
	else
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

frame1px(Minimap)
CreateShadow(Minimap)

--[[ Clock ]]
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end

local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont("Fonts\\FRIZQT__.ttf", 10, "OUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -1)
clockTime:Show()

