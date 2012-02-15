local frame = CompactRaidFrameManager
   frame:UnregisterAllEvents()
   frame.Show = function() end
   frame:Hide()
   
   local frame = CompactRaidFrameContainer
   frame:UnregisterAllEvents()
   frame.Show = function() end
   frame:Hide()
   
   
	-- local f = CreateFrame("Frame", nil, UIParent)
	-- f:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- f:SetScript("OnEvent", function(self, event)
			-- CompactRaidFrameManager:UnregisterAllEvents()
			-- CompactRaidFrameManager:Hide()
			-- CompactRaidFrameContainer:UnregisterAllEvents()
			-- CompactRaidFrameContainer:Hide()
-- end)

-- SLASH_RAIDHIDE1, SLASH_RAIDHIDE2 = '/raidhide', '/rh';
-- function SlashCmdList.RAIDHIDE(msg, editbox)
 -- print("RaidHide is active, to deactivate please disable the addon.");
-- end