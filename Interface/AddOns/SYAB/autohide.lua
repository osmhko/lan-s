local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

local autohide = CreateFrame("Frame")

local rabs = {}
local showbuttons
B.shouwbuttons = showbuttons

if _UIStanceBar and C["actionbar"].stancebarfade then table.insert(rabs, "_UIStanceBar") end
if _UIPetBar and C["actionbar"].petbarfade then table.insert(rabs, "_UIPetBar") end
if _UIActionBar1 and C["actionbar"].bar1fade then table.insert(rabs, "_UIActionBar1") end
if _UIActionBar2 and C["actionbar"].bar2fade then table.insert(rabs, "_UIActionBar2") end
if _UIActionBar3_1 and C["actionbar"].bar3_1fade then table.insert(rabs, "_UIActionBar3_1") end
if _UIActionBar3_2 and C["actionbar"].bar3_2fade then table.insert(rabs, "_UIActionBar3_2") end
if _UIActionBar4 and C["actionbar"].bar4fade then table.insert(rabs, "_UIActionBar4") end
if _UIActionBar5 and C["actionbar"].bar5fade then table.insert(rabs, "_UIActionBar5") end

if #rabs == 0 then return end

autohide:RegisterEvent("PLAYER_REGEN_ENABLED")
autohide:RegisterEvent("PLAYER_REGEN_DISABLED")
autohide:RegisterEvent("PLAYER_TARGET_CHANGED")
autohide:RegisterEvent("PLAYER_ENTERING_WORLD")
autohide:RegisterEvent("UNIT_ENTERED_VEHICLE")
autohide:RegisterEvent("UNIT_EXITED_VEHICLE")

local function pending()
	if UnitAffectingCombat("player") then return true end
	if UnitExists("target") then return true end
	if UnitInVehicle("player") then return true end
	if SpellBookFrame:IsShown() then return true end
	if IsAddOnLoaded("Blizzard_MacroUI") and MacroFrame:IsShown() then return true end
end

local function FadeOutActionButton()
	B.showbuttons = nil
	for _, v in ipairs(rabs) do 
		if C["actionbar"].bar3mode == 1 and C["actionbar"].bar3_1fade then B.B31OUT() end
		if C["actionbar"].bar3mode == 1 and C["actionbar"].bar3_2fade then B.B32OUT() end
		if _G[v]:GetAlpha()>0 then
			local fadeInfo = {};
			fadeInfo.mode = "OUT";
			fadeInfo.timeToFade = 0.3;
--			fadeInfo.finishedFunc = function() _G[v]:Hide() end
			fadeInfo.startAlpha = _G[v]:GetAlpha()
			fadeInfo.endAlpha = 0
			UIFrameFade(_G[v], fadeInfo)
		end 
	end
end

local function FadeInActionButton()
	B.showbuttons = true
	for _, v in ipairs(rabs) do
		if C["actionbar"].bar3mode == 1 and C["actionbar"].bar3_1fade then B.B31IN() end
		if C["actionbar"].bar3mode == 1 and C["actionbar"].bar3_2fade then B.B32IN() end
		if _G[v]:GetAlpha()<1 then
			_G[v]:Show()
			UIFrameFadeIn(_G[v], 0.3, _G[v]:GetAlpha(), 1)
		end
	end
end

local buttons = 0
local function UpdateButtonNumber()
	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
end
hooksecurefunc("ActionButton_UpdateFlyout", UpdateButtonNumber)
local function SetUpFlyout()
	for i=1, buttons do
		local button = _G["SpellFlyoutButton"..i]
		if button then
			if button:GetParent():GetParent():GetParent() == MultiBarLeft and C["actionbar"].bar5mouseover then
				button:SetScript("OnEnter", function(self) UIFrameFadeIn(_UIActionBar5,0.5,_UIActionBar5:GetAlpha(),1) end)
				button:SetScript("OnLeave", function(self) UIFrameFadeOut(_UIActionBar5,0.5,_UIActionBar5:GetAlpha(),0) end)
			end
			if button:GetParent():GetParent():GetParent() == MultiBarRight and C["actionbar"].bar4mouseover then
				button:SetScript("OnEnter", function(self) UIFrameFadeIn(_UIActionBar4,0.5,_UIActionBar4:GetAlpha(),1) end)
				button:SetScript("OnLeave", function(self) UIFrameFadeOut(_UIActionBar4,0.5,_UIActionBar4:GetAlpha(),0) end)
			end
			if button:GetParent():GetParent():GetParent() == MultiBarBottomRight and C["actionbar"].bar3_1mouseover then
				button:SetScript("OnEnter", function(self) UIFrameFadeIn(_UIActionBar3_1,0.5,_UIActionBar3_1:GetAlpha(),1) end)
				button:SetScript("OnLeave", function(self) UIFrameFadeOut(_UIActionBar3_1,0.5,_UIActionBar3_1:GetAlpha(),0) end)
			end
			if button:GetParent():GetParent():GetParent() == MultiBarBottomRight and C["actionbar"].bar3_2mouseover then
				button:SetScript("OnEnter", function(self) UIFrameFadeIn(_UIActionBar3_2,0.5,_UIActionBar3_2:GetAlpha(),1) end)
				button:SetScript("OnLeave", function(self) UIFrameFadeOut(_UIActionBar3_2,0.5,_UIActionBar3_2:GetAlpha(),0) end)
			end
			if button:GetParent():GetParent():GetParent() == MultiBarBottomLeft and C["actionbar"].bar2mouseover then
				button:SetScript("OnEnter", function(self) UIFrameFadeIn(_UIActionBar2,0.5,_UIActionBar2:GetAlpha(),1) end)
				button:SetScript("OnLeave", function(self) UIFrameFadeOut(_UIActionBar2,0.5,_UIActionBar2:GetAlpha(),0) end)
			end
		end
	end
end
SpellFlyout:HookScript("OnShow", SetUpFlyout)
	
autohide:SetScript("OnEvent", function(self, event, arg1, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	if pending() then
		FadeInActionButton()
	else
		FadeOutActionButton()
	end
end)

SpellBookFrame:HookScript("OnShow", function(self, event)
	FadeInActionButton()
end)

SpellBookFrame:HookScript("OnHide", function(self, event)
	if not pending() then
		FadeOutActionButton()
	end
end)

local a = CreateFrame("Frame")
a:RegisterEvent("ADDON_LOADED")
a:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_MacroUI" then
		self:UnregisterEvent("ADDON_LOADED")
		MacroFrame:HookScript("OnShow", function(self, event)
			FadeInActionButton()
		end)
		MacroFrame:HookScript("OnHide", function(self, event)
			if not pending() then
				FadeOutActionButton()
			end
		end)
	end
end)