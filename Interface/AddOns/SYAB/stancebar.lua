local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end
  
local num = NUM_SHAPESHIFT_SLOTS

local bar = CreateFrame("Frame","_UIStanceBar",UIParent, "SecureHandlerStateTemplate")
if C["actionbar"].bar3mode == 3 then
	bar:SetPoint("BOTTOMLEFT", _UIActionBar2, "TOPLEFT", 0, C["actionbar"].buttonspacing)
	bar:SetWidth(C["actionbar"].stancebuttonsize*num+(C["actionbar"].buttonspacing-1)*(num-1))
	bar:SetHeight(C["actionbar"].stancebuttonsize)
elseif C["actionbar"].bar3mode == 2 then
	bar:SetPoint("BOTTOMRIGHT", _UIActionBar1, "BOTTOMLEFT", -2*C["actionbar"].buttonspacing, 0)
	bar:SetWidth(C["actionbar"].stancebuttonsize)
	bar:SetHeight(C["actionbar"].stancebuttonsize*num+(C["actionbar"].buttonspacing-1)*(num-1))
else
	bar:SetPoint("BOTTOMLEFT", _UIActionBar3_1, "TOPLEFT", 0, C["actionbar"].buttonspacing)
	bar:SetWidth(C["actionbar"].stancebuttonsize*num+(C["actionbar"].buttonspacing-1)*(num-1))
	bar:SetHeight(C["actionbar"].stancebuttonsize)
end
--bar:SetPoint("BOTTOMLEFT", _UIActionBar3_1, "TOPLEFT", 0, C["actionbar"].buttonspacing)

bar:SetHitRectInsets(-C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset)

bar:SetScale(C["actionbar"].barscale)



ShapeshiftBarFrame:SetParent(bar)
ShapeshiftBarFrame:EnableMouse(false)

for i=1, num do
	local button = _G["ShapeshiftButton"..i]
		button:SetSize(C["actionbar"].stancebuttonsize, C["actionbar"].stancebuttonsize)
		button:ClearAllPoints()
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", bar, 0,0)
	else
		local previous = _G["ShapeshiftButton"..i-1]      
		if C["actionbar"].bar3mode == 2 then
			button:SetPoint("BOTTOM", previous, "TOP", 0, C["actionbar"].buttonspacing)
		else
			button:SetPoint("LEFT", previous, "RIGHT", C["actionbar"].buttonspacing, 0)
		end
	end
end
    
local function _UIMoveShapeshift()
	ShapeshiftButton1:SetPoint("BOTTOMLEFT", bar, 0,0)
end
hooksecurefunc("ShapeshiftBar_Update", _UIMoveShapeshift);
    
    
if C["actionbar"].stancebarmouseover then    
	--C["actionbar"].stancebarfade = false  
	bar:SetAlpha(0)
--	bar:SetScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
--	bar:SetScript("OnLeave", function(self) UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end)  
	for i=1, num do
		local pb = _G["ShapeshiftButton"..i]
		pb:HookScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
		pb:HookScript("OnLeave", function(self) if not B.showbuttons or not C["actionbar"].stancebarfade then UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end end)
	end    
end

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show,",
	["PRIEST"] = "show,",
	["HUNTER"] = "show,",
	["WARLOCK"] = "show,",
}