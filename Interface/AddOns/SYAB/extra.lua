local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

local holder = CreateFrame('Frame', nil, UIParent)
holder:Point('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 200, 400)
holder:Size(ExtraActionBarFrame:GetSize())
ExtraActionBarFrame:SetParent(holder)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint('CENTER', holder, 'CENTER')
UIPARENT_MANAGED_FRAME_POSITIONS.ExtraActionBarFrame = nil
UIPARENT_MANAGED_FRAME_POSITIONS.PlayerPowerBarAlt.extraActionBarFrame = nil
UIPARENT_MANAGED_FRAME_POSITIONS.CastingBarFrame.extraActionBarFrame = nil
ExtraActionButton1Cooldown:Point("TOPLEFT", 1, -1)
ExtraActionButton1Cooldown:Point("BOTTOMRIGHT", -1, 1)

