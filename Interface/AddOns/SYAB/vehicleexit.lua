local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

local bar = CreateFrame("Frame","_UIVehicleBar",UIParent, "SecureHandlerStateTemplate")
bar:SetHeight(24)
bar:SetWidth(24)
if C["actionbar"].bar3mode == 1 then
	bar:SetPoint("LEFT", _UIActionBar3_2, "RIGHT", 4*C["actionbar"].buttonspacing, 0)
elseif C["actionbar"].bar3mode == 2 then
	bar:SetPoint("LEFT", _UIActionBar1, "TOPRIGHT", 4*C["actionbar"].buttonspacing, .5*C["actionbar"].buttonspacing)
else
	bar:SetPoint("LEFT", _UIActionBar3_1, "RIGHT", 4*C["actionbar"].buttonspacing, 0)
end

--bar:SetHitRectInsets(-C["actionbar"].barinset+3, -C["actionbar"].barinset+3, -C["actionbar"].barinset+3, -C["actionbar"].barinset+3)
bar:SetHitRectInsets(-1,-1,-1,-1)
bar:SetScale(C["actionbar"].barscale*1.3)



local veb = CreateFrame("BUTTON", nil, bar, "SecureActionButtonTemplate");
veb:Point("TOPLEFT", -0, 0)
veb:Point("BOTTOMRIGHT", 0, -0)
veb:CreateShadow("Background", -3)
veb:RegisterForClicks("AnyUp")
veb:SetNormalTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up")
veb:SetPushedTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Down")
veb:SetHighlightTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Down")
veb:SetScript("OnClick", function(self) VehicleExit() end)
RegisterStateDriver(veb, "visibility", "[vehicleui] show;[target=vehicle,exists] show;hide")