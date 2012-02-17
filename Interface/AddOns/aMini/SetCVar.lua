SetCVar("guildShowOffline", 0)
SetCVar("deselectOnClick", 1)
SetCVar("interactOnLeftClick", 0)
SetCVar("showTargetOfTarget", 1)
SetCVar("spamFilter", 0)
SetCVar("UnitNameNPC", 1)
SetCVar("UnitNameEnemyGuardianName", 1)
SetCVar("UnitNameEnemyTotemName", 1)
SetCVar("UnitNameFriendlyGuardianName", 1)
SetCVar("UnitNameFriendlyTotemName", 1)
SetCVar("UnitNameNonCombatCreatureName", 1)
SetCVar("UnitNameFriendlySpecialNPCName", 0)
SetCVar("fctDodgeParryMiss", 1)
SetCVar("fctDamageReduction", 1)
SetCVar("fctRepChanges", 1)
SetCVar("fctFriendlyHealers", 1)
SetCVar("fctEnergyGains", 1)
SetCVar("fctPeriodicEnergyGains", 1)
SetCVar("fctHonorGains", 1)
SetCVar("fctAuras", 1)
SetCVar("showNewbieTips", 0)
SetCVar("threatShowNumeric", 1)
SetCVar("showTutorials", 0)

   
---------------- >显示颜色
   ToggleChatColorNamesByClassGroup(true, "SAY")
   ToggleChatColorNamesByClassGroup(true, "EMOTE")
   ToggleChatColorNamesByClassGroup(true, "YELL")
   ToggleChatColorNamesByClassGroup(true, "GUILD")
   ToggleChatColorNamesByClassGroup(true, "GUILD_OFFICER")
   ToggleChatColorNamesByClassGroup(true, "OFFICER")
   ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
   ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
   ToggleChatColorNamesByClassGroup(true, "WHISPER")
   ToggleChatColorNamesByClassGroup(true, "PARTY")
   ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
   ToggleChatColorNamesByClassGroup(true, "RAID")
   ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
   ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
   ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
   ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")   
   ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
   ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
   ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
   ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
   ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
   ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
   
   --每一个button的長、寬，空隙，綜合/交易/本地防務/組隊 頻道的顏色
-- local buttontex = "Interface\\AddOns\\m_chat\\textures\\bartexture"
-- local buttonwidth, buttonheight, buttonspacing = 25, 12, 2.5
-- local c1r, c1g, c1b = 160/255, 200/255 ,215/255  --綜合
-- local c2r, c2g, c2b = 255/255, 130/255, 130/255  --交易
-- local c3r, c3g, c3b = 255/255, 255/255, 150/255  --防務
-- local c4r, c4g, c4b = 150/255, 255/255, 185/255  --組隊


--local chat = CreateFrame("Frame","chat",UIParent)
--chat:RegisterEvent("PLAYER_ENTERING_WORLD")
--這一段是定義頻道顏色的，如果不喜歡就刪掉
-- chat:SetScript("OnEvent", function(self, event)
    -- if event == "PLAYER_ENTERING_WORLD" then
	    -- ChangeChatColor("CHANNEL1", c1r, c1g, c1b)
		-- ChangeChatColor("CHANNEL2", c2r, c2g, c2b)
		-- ChangeChatColor("CHANNEL3", c3r, c3g, c3b)
		-- ChangeChatColor("CHANNEL4", c4r, c4g, c4b)
		-- ChangeChatColor("CHANNEL5", c2r, c2g, c2b)
		-- ChangeChatColor("CHANNEL6", 1/255 234/255 255/255)
	-- end
-- end)