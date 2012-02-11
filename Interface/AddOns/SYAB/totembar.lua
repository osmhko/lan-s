local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end
  
if B.myclass ~= "SHAMAN" then return end

if MultiCastActionBarFrame then
	MultiCastActionBarFrame:SetScript("OnUpdate", nil)
	MultiCastActionBarFrame:SetScript("OnShow", nil)
	MultiCastActionBarFrame:SetScript("OnHide", nil)
	MultiCastActionBarFrame:SetParent(_UIStanceBar)
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", _UIStanceBar, "BOTTOMLEFT", -2, -2)

	hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
	
	MultiCastActionBarFrame.SetParent = B.dummy
	MultiCastActionBarFrame.SetPoint = B.dummy
	MultiCastRecallSpellButton.SetPoint = B.dummy -- bug fix, see http://www.tukui.org/v2/forums/topic.php?id=2405
end