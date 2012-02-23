--print ("喵喵喵")
local cfg = {}
--------------------------------------------------------------------------------------
--CONFIG
--------------------------------------------------------------------------------------
cfg.font = "Fonts\\Zykai_T.ttf"
cfg.fontsize = 12
cfg.fontflag = nil						-- outline type
--cfg.bordersize = 1.2805
cfg.shadow1size = 12
--------------------------------------------------------------------------------------
--CONFIG END
--------------------------------------------------------------------------------------
local class = select(2,UnitClass'player')
local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
--print (class..":"..classcolor.r..","..classcolor.g..","..classcolor.b)
local glow, blank, status = "Interface\\Addons\\Beauty\\media\\glowTex", "Interface\\Addons\\Beauty\\media\\blank", "Interface\\Addons\\Beauty\\media\\statusbar"
local function RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

local function ShortValue(v)
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

local function SpawnBags(p,w)
	local info = p
	info:Width(w)
	info.mouse = CreateFrame("Frame",nil,UI_Parent)
	info.mouse:SetPoint("TOPLEFT", info)
	info.mouse:SetPoint("BOTTOMRIGHT", UI_Parent)
	info.Status:SetScript("OnEvent", function(self)
		local free, total = 0, 0
		for j = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(j), total + GetContainerNumSlots(j)
		end
		self:SetValue(total-free)
		self:SetMinMaxValues(0, total)
		info.Text:SetText("B:"..RGBToHex(1-free/total, .2+.8*free/total, .2-.2*free/total)..free.."/"..total.."|r")
	--	self:SetStatusBarColor(.6+.4*(1-free/total), free/total, .2*free/total, 1)
	end)
	info.mouse:SetScript("OnMouseDown", function()
		GameTooltip:Hide() 
		if (BagsFrame and BagsFrame:IsShown()) or ContainerFrame1:IsShown() or ContainerFrame2:IsShown() or ContainerFrame3:IsShown() or ContainerFrame4:IsShown() or ContainerFrame5:IsShown() then CloseAllBags() else OpenAllBags() end
	end)
	info.mouse:SetScript("OnEnter", function(self)
		local free, total = 0, 0
		if info:IsShown() then
			if not InCombatLockdown() then
				for j = 0, NUM_BAG_SLOTS do
					free, total = free + GetContainerNumFreeSlots(j), total + GetContainerNumSlots(j)
				end
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -31, 0)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine("背包", free.."/"..total)
				for i = 0, NUM_BAG_SLOTS do
					if GetBagName(i) then
						local bagLink = GetBagName(i)
						GameTooltip:AddDoubleLine("["..bagLink.."]", GetContainerNumFreeSlots(i).."/"..GetContainerNumSlots(i), 1 ,1 , 1, 0, 1, 0)
					end
				end
				GameTooltip:Show()
			end
		end
	end)
	info.mouse:SetScript("OnLeave", function() GameTooltip:Hide() end)
	info.Status:RegisterEvent("BAG_UPDATE")
	info.Status:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function SpawnFriend(p,w)
	p:Width(w)
	local info = p
	-- create a popup
	StaticPopupDialogs.SET_BN_BROADCAST = {
		text = BN_BROADCAST_TOOLTIP,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		editBoxWidth = 350,
		maxLetters = 127,
		OnAccept = function(self) BNSetCustomMessage(self.editBox:GetText()) end,
		OnShow = function(self) self.editBox:SetText(select(3, BNGetInfo()) ) self.editBox:SetFocus() end,
		OnHide = ChatEdit_FocusActiveWindow,
		EditBoxOnEnterPressed = function(self) BNSetCustomMessage(self:GetText()) self:GetParent():Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	-- localized references for global functions (about 50% faster)
	local join 			= string.join
	local find			= string.find
	local format		= string.format
	local sort			= table.sort

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)
	Stat:SetParent(info)

	local menuFrame = CreateFrame("Frame", "RayUIFriendRightClickMenu", UIParent, "UIDropDownMenuTemplate")
	local menuList = {
		{ text = OPTIONS_MENU, isTitle = true,notCheckable=true},
		{ text = INVITE, hasArrow = true,notCheckable=true, },
		{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true,notCheckable=true, },
		{ text = PLAYER_STATUS, hasArrow = true, notCheckable=true,
			menuList = {
				{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable=true, func = function() if IsChatAFK() then SendChatMessage("", "AFK") elseif IsChatDND() then SendChatMessage("", "DND") end end },
				{ text = "|cffE7E716"..DND.."|r", notCheckable=true, func = function() if not IsChatDND() then SendChatMessage("", "DND") end end },
				{ text = "|cffFF0000"..AFK.."|r", notCheckable=true, func = function() if not IsChatAFK() then SendChatMessage("", "AFK") end end },
			},
		},
		{ text = BN_BROADCAST_TOOLTIP, notCheckable=true, func = function() StaticPopup_Show("SET_BN_BROADCAST") end },
	}

	local function inviteClick(self, arg1, arg2, checked)
		menuFrame:Hide()
		InviteUnit(arg1)
	end

	local function whisperClick(self,arg1,arg2,checked)
		menuFrame:Hide() 
		SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )		 
	end

	local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
	local clientLevelNameString = "%s |cff%02x%02x%02x(%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r"
	local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
	local worldOfWarcraftString = "World of Warcraft"
	local battleNetString = "Battle.NET"
	local wowString = "WoW"
	local otherGameInfoString = "%s (%s)"
	local otherGameInfoString2 = "%s %s"
	local totalOnlineString = join("", FRIENDS_LIST_ONLINE, ": %s/%s")
	local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
	local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
	local displayString = join("", "%s: ", "", "%d|r")
	local statusTable = { "[AFK]", "[DND]", "" }
	local groupedTable = { "|cffaaaaaa*|r", "" } 
	local friendTable, BNTable = {}, {}
	local friendOnline, friendOffline = gsub(ERR_FRIEND_ONLINE_SS,"\124Hplayer:%%s\124h%[%%s%]\124h",""), gsub(ERR_FRIEND_OFFLINE_S,"%%s","")
	local dataValid = false

	local function BuildFriendTable(total)
		wipe(friendTable)
		local name, level, class, area, connected, status, note
		for i = 1, total do
			name, level, class, area, connected, status, note = GetFriendInfo(i)
			
			if connected then 
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				friendTable[i] = { name, level, class, area, connected, status, note }
			end
		end
		sort(friendTable, function(a, b)
			if a[1] and b[1] then
				return a[1] < b[1]
			end
		end)
	end

	local function BuildBNTable(total)
		wipe(BNTable)
		local presenceID, givenName, surname, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level
		for i = 1, total do
			presenceID, givenName, surname, toonName, toonID, client, isOnline, _, isAFK, isDND, _, noteText = BNGetFriendInfo(i)
			
			if isOnline then 
				_, _, _, realmName, _, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				BNTable[i] = { presenceID, surname, givenName, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level }
			end
		end
		sort(BNTable, function(a, b)
			if a[2] and b[2] then
				if a[2] == b[2] then return a[3] < b[3] end
				return a[2] < b[2]
			end
		end)
	end

	local function Update(self, event, ...)
		local totalFriends, onlineFriends = GetNumFriends()
		local totalBN, numBNetOnline = BNGetNumFriends()

		-- special handler to detect friend coming online or going offline
		-- when this is the case, we invalidate our buffered table and update the 
		-- datatext information
		if event == "CHAT_MSG_SYSTEM" then
			local message = select(1, ...)
			if not (find(message, friendOnline) or find(message, friendOffline)) then return end
		end

		-- force update when showing tooltip
		dataValid = false

		info.Text:SetText("F:"..onlineFriends + numBNetOnline)--FormattedText(displayString, FRIENDS, onlineFriends + numBNetOnline)
		info.Status:SetMinMaxValues(0, totalFriends + totalBN)
		info.Status:SetValue(onlineFriends + numBNetOnline)
		self:SetAllPoints(info)
	end

	Stat:SetScript("OnMouseUp", function(self, btn)
		if btn ~= "RightButton" then return end
		
		GameTooltip:Hide()
		
		local menuCountWhispers = 0
		local menuCountInvites = 0
		local classc, levelc, info
		
		menuList[2].menuList = {}
		menuList[3].menuList = {}
		
		if #friendTable > 0 then
			for i = 1, #friendTable do
				info = friendTable[i]
				if (info[5]) then
					menuCountInvites = menuCountInvites + 1
					menuCountWhispers = menuCountWhispers + 1
		
					classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[3]], GetQuestDifficultyColor(info[2])
					if classc == nil then classc = GetQuestDifficultyColor(info[2]) end
		
					menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],classc.r*255,classc.g*255,classc.b*255,info[1]), arg1 = info[1],notCheckable=true, func = inviteClick}
					menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],classc.r*255,classc.g*255,classc.b*255,info[1]), arg1 = info[1],notCheckable=true, func = whisperClick}
				end
			end
		end
		if #BNTable > 0 then
			local realID, playerFaction, grouped
			for i = 1, #BNTable do
				info = BNTable[i]
				if (info[7]) then
					realID = (BATTLENET_NAME_FORMAT):format(info[2], info[3])
					menuCountWhispers = menuCountWhispers + 1
					menuList[3].menuList[menuCountWhispers] = {text = realID, arg1 = realID,notCheckable=true, func = whisperClick}

					if select(1, UnitFactionGroup("player")) == "Horde" then playerFaction = 0 else playerFaction = 1 end
					if info[6] == wowString and info[11] == GetRealmName() and playerFaction == info[12] then
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[14]], GetQuestDifficultyColor(info[16])
						if classc == nil then classc = GetQuestDifficultyColor(info[16]) end

						if UnitInParty(info[4]) or UnitInRaid(info[4]) then grouped = 1 else grouped = 2 end
						menuCountInvites = menuCountInvites + 1
						menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[16],classc.r*255,classc.g*255,classc.b*255,info[4]), arg1 = info[4],notCheckable=true, func = inviteClick}
					end
				end
			end
		end

		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	end)
		
	Stat:SetScript("OnMouseDown", function(self, btn) if btn == "LeftButton" then ToggleFriendsFrame(1) end end)

	Stat:SetScript("OnEnter", function(self)
		if InCombatLockdown() then return end

		local numberOfFriends, onlineFriends = GetNumFriends()
		local totalBNet, numBNetOnline = BNGetNumFriends()
			
		local totalonline = onlineFriends + numBNetOnline
		
		-- no friends online, quick exit
		if totalonline == 0 then return end

		if not dataValid then
			-- only retrieve information for all on-line members when we actually view the tooltip
			if numberOfFriends > 0 then BuildFriendTable(numberOfFriends) end
			if totalBNet > 0 then BuildBNTable(totalBNet) end
			dataValid = true
		end

		local totalfriends = numberOfFriends + totalBNet
		local zonec, classc, levelc, realmc, info

		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(FRIENDS_LIST..":", format(totalOnlineString, totalonline, totalfriends),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
		if onlineFriends > 0 then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(worldOfWarcraftString)
			for i = 1, #friendTable do
				info = friendTable[i]
				if info[5] then
					if GetRealZoneText() == info[4] then zonec = activezone else zonec = inactivezone end
					classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[3]], GetQuestDifficultyColor(info[2])
					if classc == nil then classc = GetQuestDifficultyColor(info[2]) end
					
					if UnitInParty(info[1]) or UnitInRaid(info[1]) then grouped = 1 else grouped = 2 end
					GameTooltip:AddDoubleLine(format(levelNameClassString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],info[1],groupedTable[grouped]," "..info[6]),info[4],classc.r,classc.g,classc.b,zonec.r,zonec.g,zonec.b)
				end
			end
		end

		if numBNetOnline > 0 then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(battleNetString)

			local status = 0
			for i = 1, #BNTable do
				info = BNTable[i]
				if info[7] then
					if info[6] == wowString then
						if (info[8] == true) then status = 1 elseif (info[9] == true) then status = 2 else status = 3 end

						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[14]], GetQuestDifficultyColor(info[16])
						if classc == nil then classc = GetQuestDifficultyColor(info[16]) end
						
						if UnitInParty(info[4]) or UnitInRaid(info[4]) then grouped = 1 else grouped = 2 end
						GameTooltip:AddDoubleLine(format(clientLevelNameString, info[6],levelc.r*255,levelc.g*255,levelc.b*255,info[16],classc.r*255,classc.g*255,classc.b*255,info[4],groupedTable[grouped], 255, 0, 0, statusTable[status]),info[2].." "..info[3],238,238,238,238,238,238)
						if IsShiftKeyDown() then
							if GetRealZoneText() == info[15] then zonec = activezone else zonec = inactivezone end
							if GetRealmName() == info[11] then realmc = activezone else realmc = inactivezone end
							GameTooltip:AddDoubleLine(info[15], info[11], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
						end
					else
						GameTooltip:AddDoubleLine(format(otherGameInfoString, info[6], info[4]), format(otherGameInfoString2, info[2], info[3]), .9, .9, .9, .9, .9, .9)
					end
				end
			end
		end

		GameTooltip:Show()	
	end)

	Stat:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	Stat:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	Stat:RegisterEvent("BN_FRIEND_INFO_CHANGED")
	Stat:RegisterEvent("BN_FRIEND_TOON_ONLINE")
	Stat:RegisterEvent("BN_FRIEND_TOON_OFFLINE")
	Stat:RegisterEvent("BN_TOON_NAME_UPDATED")
	Stat:RegisterEvent("FRIENDLIST_UPDATE")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("CHAT_MSG_SYSTEM")

	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnEvent", Update)
	Update(Stat)
end

local function SpawnGuild(p,w)
	local info = p
	-- localized references for global functions (about 50% faster)
	local join 			= string.join
	local format		= string.format
	local find			= string.find
	local gsub			= string.gsub
	local sort			= table.sort
	local ceil			= math.ceil

	local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
	local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
	local displayString = join("", GUILD, ": %d|r")
	local noGuildString = join("", "", "没有工会")
	local guildInfoString = "%s [%d]"
	local guildInfoString2 = join("", GUILD, ": %d/%d")
	local guildMotDString = "%s |cffaaaaaa- |cffffffff%s"
	local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s"
	local levelNameStatusString = "|cff%02x%02x%02x%d|r %s %s"
	local nameRankString = "%s |cff999999-|cffffffff %s"
	local guildXpCurrentString = gsub(join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), GUILD_EXPERIENCE_CURRENT), ": ", ":|r |cffffffff", 1)
	local guildXpDailyString = gsub(join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), GUILD_EXPERIENCE_DAILY), ": ", ":|r |cffffffff", 1)
	local standingString = join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), "%s:|r |cFFFFFFFF%s/%s (%s%%)")
	local moreMembersOnlineString = join("", "+ %d ", FRIENDS_LIST_ONLINE, "...")
	local noteString = join("", "|cff999999   ", LABEL_NOTE, ":|r %s")
	local officerNoteString = join("", "|cff999999   ", GUILD_RANK1_DESC, ":|r %s")
	local friendOnline, friendOffline = gsub(ERR_FRIEND_ONLINE_SS,"\124Hplayer:%%s\124h%[%%s%]\124h",""), gsub(ERR_FRIEND_OFFLINE_S,"%%s","")
	local guildTable, guildXP, guildMotD = {}, {}, ""

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)
	Stat:SetParent(info)

	local function SortGuildTable(shift)
		sort(guildTable, function(a, b)
			if a and b then
				if shift then
					return a[10] < b[10]
				else
					return a[1] < b[1]
				end
			end
		end)
	end

	local function BuildGuildTable()
		wipe(guildTable)
		local name, rank, level, zone, note, officernote, connected, status, class
		local count = 0
		for i = 1, GetNumGuildMembers() do
			name, rank, rankIndex, level, _, zone, note, officernote, connected, status, class = GetGuildRosterInfo(i)
			-- we are only interested in online members
			
			if connected then 
				count = count + 1
				guildTable[count] = { name, rank, level, zone, note, officernote, connected, status, class, rankIndex }
			end
		end
		SortGuildTable(IsShiftKeyDown())
	end


	local function UpdateGuildXP()
		local currentXP, remainingXP, dailyXP, maxDailyXP = UnitGetGuildXP("player")
		local nextLevelXP = currentXP + remainingXP
		local percentTotal = ceil((currentXP / nextLevelXP) * 100)
		local percentDaily = ceil((dailyXP / maxDailyXP) * 100)
		
		guildXP[0] = { currentXP, nextLevelXP, percentTotal }
		guildXP[1] = { dailyXP, maxDailyXP, percentDaily }
	end

	local function UpdateGuildMessage()
		guildMotD = GetGuildRosterMOTD()
	end

	local function Update(self, event, ...)	
		if IsInGuild() then
			p:Width(w)
			-- special handler to request guild roster updates when guild members come online or go
			-- offline, since this does not automatically trigger the GuildRoster update from the server
			if event == "CHAT_MSG_SYSTEM" then
				local message = select(1, ...)
				if find(message, friendOnline) or find(message, friendOffline) then GuildRoster() end
			end
			-- our guild xp changed, recalculate it
			if event == "GUILD_XP_UPDATE" then UpdateGuildXP() return end
			-- our guild message of the day changed
			if event == "GUILD_MOTD" then UpdateGuildMessage() return end
			-- when we enter the world and guildframe is not available then
			-- load guild frame, update guild message and guild xp
			if event == "PLAYER_ENTERING_WORLD" then
				if not GuildFrame and IsInGuild() then LoadAddOn("Blizzard_GuildUI") UpdateGuildMessage() UpdateGuildXP() end
			end
			-- an event occured that could change the guild roster, so request update, and wait for guild roster update to occur
			if event ~= "GUILD_ROSTER_UPDATE" and event~="PLAYER_GUILD_UPDATE" then GuildRoster() return end

			local total, online = GetNumGuildMembers()
			
			info.Text:SetText("G:"..online)--FormattedText(displayString, online)
			info.Status:SetMinMaxValues(0, total)
			info.Status:SetValue(online)
		else
			info.Text:SetText("")
			info:Width(0)
		end
		self:SetAllPoints(info)
	end
		
	local menuFrame = CreateFrame("Frame", "GuildRightClickMenu", UIParent, "UIDropDownMenuTemplate")
	local menuList = {
		{ text = OPTIONS_MENU, isTitle = true, notCheckable=true},
		{ text = INVITE, hasArrow = true, notCheckable=true,},
		{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable=true,}
	}

	local function inviteClick(self, arg1, arg2, checked)
		menuFrame:Hide()
		InviteUnit(arg1)
	end

	local function whisperClick(self,arg1,arg2,checked)
		menuFrame:Hide()
		SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )
	end

	local function ToggleGuildFrame()
		if IsInGuild() then
			if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end
			GuildFrame_Toggle()
			GuildFrame_TabClicked(GuildFrameTab2)
		else
			if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end
			if LookingForGuildFrame then LookingForGuildFrame_Toggle() end
		end
	end

	Stat:SetScript("OnMouseUp", function(self, btn)
		if btn ~= "RightButton" or not IsInGuild() then return end
		if InCombatLockdown() then return end
		
		GameTooltip:Hide()

		local classc, levelc, grouped, info
		local menuCountWhispers = 0
		local menuCountInvites = 0

		menuList[2].menuList = {}
		menuList[3].menuList = {}

		for i = 1, #guildTable do
			info = guildTable[i]
			if info[7] and info[1] ~= UnitName("player") then
				local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[9]], GetQuestDifficultyColor(info[3])

				if UnitInParty(info[1]) or UnitInRaid(info[1]) then
					grouped = "|cffaaaaaa*|r"
				else
					menuCountInvites = menuCountInvites +1
					grouped = ""
					menuList[2].menuList[menuCountInvites] = {text = format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, info[3], classc.r*255,classc.g*255,classc.b*255, info[1], ""), arg1 = info[1],notCheckable=true, func = inviteClick}
				end
				menuCountWhispers = menuCountWhispers + 1
				menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, info[3], classc.r*255,classc.g*255,classc.b*255, info[1], grouped), arg1 = info[1],notCheckable=true, func = whisperClick}
			end
		end

		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	end)

	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn ~= "LeftButton" then return end
		ToggleGuildFrame()
	end)

	Stat:SetScript("OnEnter", function(self)
		if InCombatLockdown() or not IsInGuild() then return end
		
		local total, online = GetNumGuildMembers()
		GuildRoster()
		BuildGuildTable()
		
		
		local guildName, guildRank = GetGuildInfo('player')
		local guildLevel = GetGuildLevel()

		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(format(guildInfoString, guildName, guildLevel), format(guildInfoString2, online, total),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
		GameTooltip:AddLine(guildRank, unpack(tthead))
		GameTooltip:AddLine(' ')
		
		if guildMotD ~= "" then GameTooltip:AddLine(format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
		
		local col = RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b)
		GameTooltip:AddLine(' ')
		if GetGuildLevel() ~= 25 then
			if guildXP[0] and guildXP[1] then
				local currentXP, nextLevelXP, percentTotal = unpack(guildXP[0])
				local dailyXP, maxDailyXP, percentDaily = unpack(guildXP[1])
						
				GameTooltip:AddLine(format(guildXpCurrentString, ShortValue(currentXP), ShortValue(nextLevelXP), percentTotal))
				GameTooltip:AddLine(format(guildXpDailyString, ShortValue(dailyXP), ShortValue(maxDailyXP), percentDaily))
			end
		end
		
		local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
		if standingID ~= 8 then -- Not Max Rep
			barMax = barMax - barMin
			barValue = barValue - barMin
			barMin = 0
			GameTooltip:AddLine(format(standingString, COMBAT_FACTION_CHANGE, ShortValue(barValue), ShortValue(barMax), ceil((barValue / barMax) * 100)))
		end
		
		local zonec, classc, levelc, info
		local shown = 0
		
		GameTooltip:AddLine(' ')
		for i = 1, #guildTable do
			-- if more then 30 guild members are online, we don't Show any more, but inform user there are more
			if 30 - shown <= 1 then
				if online - 30 > 1 then GameTooltip:AddLine(format(moreMembersOnlineString, online - 30), ttsubh.r, ttsubh.g, ttsubh.b) end
				break
			end

			info = guildTable[i]
			if GetRealZoneText() == info[4] then zonec = activezone else zonec = inactivezone end
			classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[9]], GetQuestDifficultyColor(info[3])
			
			if info[8] == 0 then info[8] = ""
			elseif info[8] == 1 then info[8] = "<AFK>"
			else info[8] = "<DND>"
			end
			
			if IsShiftKeyDown() then
				GameTooltip:AddDoubleLine(format(nameRankString, info[1], info[2]), info[4], classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
				if info[5] ~= "" then GameTooltip:AddLine(format(noteString, info[5]), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
				if info[6] ~= "" then GameTooltip:AddLine(format(officerNoteString, info[6]), ttoff.r, ttoff.g, ttoff.b, 1) end
			else
				GameTooltip:AddDoubleLine(format(levelNameStatusString, levelc.r*255, levelc.g*255, levelc.b*255, info[3], info[1], info[8]), info[4], classc.r,classc.g,classc.b, zonec.r,zonec.g,zonec.b)
			end
			shown = shown + 1
		end
		GameTooltip:Show()
	end)

	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)

	Stat:RegisterEvent("GUILD_ROSTER_SHOW")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("GUILD_ROSTER_UPDATE")
	Stat:RegisterEvent("GUILD_XP_UPDATE")
	Stat:RegisterEvent("PLAYER_GUILD_UPDATE")
	Stat:RegisterEvent("GUILD_MOTD")
	Stat:RegisterEvent("CHAT_MSG_SYSTEM")
	Stat:SetScript("OnEvent", Update)
	Update(Stat)
end

local function SpawnDurability(p,w)
	local info = p
	info:Width(w)
	local Slots = {
			[1] = {1, INVTYPE_HEAD, 1000},
			[2] = {3, INVTYPE_SHOULDER, 1000},
			[3] = {5, INVTYPE_ROBE, 1000},
			[4] = {6, INVTYPE_WAIST, 1000},
			[5] = {9, INVTYPE_WRIST, 1000},
			[6] = {10, INVTYPE_HAND, 1000},
			[7] = {7, INVTYPE_LEGS, 1000},
			[8] = {8, INVTYPE_FEET, 1000},
			[9] = {16, INVTYPE_WEAPONMAINHAND, 1000},
			[10] = {17, INVTYPE_WEAPONOFFHAND, 1000},
			[11] = {18, INVTYPE_RANGED, 1000}
		}
	local tooltipString = "%d %%"
	local function Event(self)
		local Total = 0
		local current, max
		
		for i = 1, 11 do
			if GetInventoryItemLink("player", Slots[i][1]) ~= nil then
				current, max = GetInventoryItemDurability(Slots[i][1])
				if current then 
					Slots[i][3] = current/max
					Total = Total + 1
				end
			end
		end
		table.sort(Slots, function(a, b) return a[3] < b[3] end)
		local value = floor(Slots[1][3]*100)

		self:SetMinMaxValues(0, 100)
		self:SetValue(value)
		local color = value < 10 and "|cffFF3333" or value < 30 and "|cffFFFF33" or value < 100 and "|cff11FF11" or "|cff68CCEF"
		info.Text:SetText("D:"..color..value.."%|r")
	end
	info.Status:SetScript("OnEvent", Event)
	info.Status:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(DURABILITY..":")
			for i = 1, 11 do
				if Slots[i][3] ~= 1000 then
					green = Slots[i][3]*2
					red = 1 - green
					GameTooltip:AddDoubleLine(Slots[i][2], format(tooltipString, floor(Slots[i][3]*100)), 1 ,1 , 1, red + 1, green, 0)
				end
			end
			GameTooltip:Show()
		end
	end)
	info.Status:SetScript("OnLeave", function() GameTooltip:Hide() end)
	info.Status:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	info.Status:RegisterEvent("MERCHANT_SHOW")
	info.Status:RegisterEvent("PLAYER_ENTERING_WORLD")
	Event(info.Status)
end

local function SpawnTalent(p,w)
	p:Width(w)
	local talent = {}
	local active
	local talentString = string.join("", "|cffFFFFFF%s:|r %d/%d/%d")
	local activeString = string.join("", "|cff00FF00" , ACTIVE_PETS, "|r")
	local inactiveString = string.join("", "|cffFF0000", FACTION_INACTIVE, "|r")
	
	p.icon = p:CreateTexture()
	p.icon:SetSize(18,18)
	p.icon:SetPoint("LEFT",p,"LEFT",0,-1)
	p.Text:ClearAllPoints()
	p.Text:SetPoint("LEFT",p.icon,"RIGHT",2,0)

	local function LoadTalentTrees()
		for i = 1, GetNumTalentGroups(false, false) do
			talent[i] = {} -- init talent group table
			for j = 1, GetNumTalentTabs(false, false) do
				talent[i][j] = select(5, GetTalentTabInfo(j, false, false, i))
			end
		end
	end

	local int = 1
	local function Update(self, t)
		int = int - t
		if int > 0 or not GetPrimaryTalentTree() then return end

		active = GetActiveTalentGroup(false, false)
		p.Text:SetFormattedText(talentString, select(2, GetTalentTabInfo(GetPrimaryTalentTree(false, false, active))), talent[active][1], talent[active][2], talent[active][3])
		p.icon:SetTexture(select(4,GetTalentTabInfo(GetPrimaryTalentTree())))
		p.icon:SetTexCoord(.08,.92,.08,.92)
		int = 1

		-- disable script	
		self:SetScript("OnUpdate", nil)
	end

	p:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)

		GameTooltip:ClearLines()
		GameTooltip:AddLine(TALENTS..":")
		for i = 1, GetNumTalentGroups() do
			if GetPrimaryTalentTree(false, false, i) then
				GameTooltip:AddLine(string.join(" ", string.format(talentString, select(2, GetTalentTabInfo(GetPrimaryTalentTree(false, false, i))), talent[i][1], talent[i][2], talent[i][3]), (i == active and activeString or inactiveString)),1,1,1)
			end
		end
		GameTooltip:Show()
	end)

	p:SetScript("OnLeave", function() GameTooltip:Hide() end)

	local function OnEvent(self, event, ...)
		-- load talent information
		LoadTalentTrees()		
		-- update datatext
		self:SetScript("OnUpdate", Update)
	end

	p:RegisterEvent("CHARACTER_POINTS_CHANGED");
	p:RegisterEvent("PLAYER_TALENT_UPDATE");
	p:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	p:SetScript("OnEvent", OnEvent)
	p:SetScript("OnUpdate", Update)

	p:SetScript("OnMouseDown", function(_,btn)
		if btn == "LeftButton" then	securecall(ToggleTalentFrame) else
		SetActiveTalentGroup(active == 1 and 2 or 1) end
	end)
end

local function SpawnLatency(p,w)
	p:Width(w)
	local LastUpdate = 0
	p.Text:SetText("0ms")
	p.Status:SetScript("OnUpdate", function(self, elapsed)
		LastUpdate = LastUpdate - elapsed
		if LastUpdate < 0 then
			self:SetMinMaxValues(0, 1000)
			local _,_,value1,value2 = GetNetStats()
			local max = 1000
			p.Text:SetText(RGBToHex(value1/1000, .8-.8*value1/1000, .2+.8*value1/1000)..value1.."|rms / "..RGBToHex(value2/1000, .8-.8*value2/1000, .2+.8*value2/1000)..value2.."|rms")
			LastUpdate = 1
		end
	end)
	p.Status:SetScript("OnEnter", function(self)
		local _,_,value1,value2 = GetNetStats()
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine("本地: "..RGBToHex(value1/1000, .8-.8*value1/1000, .2+.8*value1/1000)..value1.."|rms", "世界: "..RGBToHex(value2/1000, .8-.8*value2/1000, .2+.8*value2/1000)..value2.."|rms")
		GameTooltip:Show()
	end)
	p.Status:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local function SpawnMemory(p,w)
	p:Width(w)
	local int = 10
	local bandwidthString = "%.2f Mbps"
	local percentageString = "%.2f%%"
	local homeLatencyString = "%d ms"
	local kiloByteString = "%d K|riB"
	local megaByteString = "%.2f M|riB"

	local function formatMem(memory)
		local mult = 10^1
		if memory > 999 then
			local mem = ((memory/1024) * mult) / mult
			return string.format(megaByteString, mem)
		else
			local mem = (memory * mult) / mult
			return string.format(kiloByteString, mem)
		end
	end

	local memoryTable = {}

	local function RebuildAddonList(self)
		local addOnCount = GetNumAddOns()
		if (addOnCount == #memoryTable) then return end
		memoryTable = {}
		for i = 1, addOnCount do
			memoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
		end
	--	self:SetAllPoints(p)
	end

	local function UpdateMemory()
		UpdateAddOnMemoryUsage()
		local addOnMem = 0
		local totalMemory = 0
		for i = 1, #memoryTable do
			addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
			memoryTable[i][3] = addOnMem
			totalMemory = totalMemory + addOnMem
		end
		table.sort(memoryTable, function(a, b)
			if a and b then
				return a[3] > b[3]
			end
		end)
		return totalMemory
	end

	local function UpdateMem(self, t)
		int = int - t
		
		if int < 0 then
			RebuildAddonList(self)
			local total = UpdateMemory()
			p.Text:SetText(RGBToHex(total/15000, 1-.8*total/15000, .8-.8*total/15000)..formatMem(total))
			int = 10
		end
	end

	local Stat = CreateFrame("Frame", nil, p)
	Stat:EnableMouse(true)
	Stat:SetFrameStrata(p:GetFrameStrata())
	Stat:SetFrameLevel(p:GetFrameLevel() + 5)
	Stat:ClearAllPoints()
	Stat:SetAllPoints(p)
	
	Stat:SetScript("OnMouseDown", function(self)
		UpdateAddOnMemoryUsage()
		local before = gcinfo()
		collectgarbage()
		UpdateAddOnMemoryUsage()
		DEFAULT_CHAT_FRAME:AddMessage(format("%s %s","共释放内存",formatMem(before - gcinfo())))
	end)
	Stat:SetScript("OnUpdate", UpdateMem)
	Stat:SetScript("OnEnter", function(self)
		local bandwidth = GetAvailableBandwidth()
		local home_latency = select(3, GetNetStats()) 
		local anchor, panel, xoff, yoff = "ANCHOR_BOTTOMRIGHT", self, 0, 0
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		
		GameTooltip:AddDoubleLine("本地延迟"..": ", string.format(homeLatencyString, home_latency), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		
		if bandwidth ~= 0 then
			GameTooltip:AddDoubleLine("带宽"..": " , string.format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine("下载"..": " , string.format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
		end
		local totalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine("总共内存使用"..": ", formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		for i = 1, #memoryTable do
			if (memoryTable[i][4]) then
				local red = memoryTable[i][3] / totalMemory
				local green = 1 - red
				GameTooltip:AddDoubleLine(memoryTable[i][2], formatMem(memoryTable[i][3]), 1, 1, 1, red, green + .5, 0)
			end						
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	UpdateMem(Stat, 10)
end

local function SpawnFPS(p,w)
	p:Width(w)
	local LastUpdate = 1
	p.Status:SetScript("OnUpdate", function(self, elapsed)
		LastUpdate = LastUpdate - elapsed
		
		if LastUpdate < 0 then
			self:SetMinMaxValues(0, 60)
			local value = floor(GetFramerate())
			value = value > 30 and "|cff11FF11"..value or "|cffFF3333"..value
			p.Text:SetText(value.."|rfps")
			LastUpdate = 1
		end
	end)
end

local load = CreateFrame("Frame")
load:RegisterEvent("PLAYER_ENTERING_WORLD")
load:SetScript("OnEvent", function(self) 
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	local bordersize = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/GetCVar("uiScale")
	local shadowsize = (bordersize*math.floor(cfg.shadow1size/bordersize+.5))
--	print (GetCVar("uiScale"))
--	print (bordersize)
	local bottom = CreateFrame("Frame", "BottemInfoPanel", UIParent)
	bottom:SetFrameStrata("BACKGROUND")
	bottom:SetFrameLevel(1)
	bottom:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", -1, 18)
	bottom:SetPoint("BOTTOMRIGHT", UIParent, 1, -1)
	bottom:SetBackdrop({
			edgeFile = blank,
			edgeSize = bordersize,
	})
	bottom:SetBackdropBorderColor(0,0,0,1)--(classcolor.r, classcolor.g, classcolor.b, 1)

	bottom.bg = CreateFrame("Frame", "BottemInfoPanel", bottom)
	bottom.bg:SetFrameStrata("BACKGROUND")
	bottom.bg:SetAllPoints(bottom)
	bottom.bg:SetFrameLevel(0)
	bottom.gradient = bottom.bg:CreateTexture()
	bottom.gradient:SetTexture(blank)
	bottom.gradient:SetAllPoints(bottom)
	bottom.gradient:SetGradientAlpha("VERTICAL", .05, .05, .05, .3, .05, .05, .05, .8)

	bottom.shadow = CreateFrame("Frame", nil, bottom)
	bottom.shadow:SetPoint("TOPLEFT", -shadowsize, shadowsize)
	bottom.shadow:SetPoint("BOTTOMRIGHT", shadowsize, -shadowsize)
	bottom.shadow:SetBackdrop({
			edgeFile = glow,
			edgeSize = shadowsize,
	})
	bottom.shadow:SetBackdropBorderColor(.05, .05, .05, .9)

	local top = CreateFrame("Frame", "TopInfoPanel", UIParent)
	top:SetFrameStrata("BACKGROUND")
	top:SetFrameLevel(1)
	top:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -1, -20)
	top:SetPoint("TOPRIGHT", UIParent, 1, 1)
	top:SetBackdrop({
			edgeFile = blank,
			edgeSize = bordersize,
	})
	top:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)

	top.bg = CreateFrame("Frame", "TopInfoPanel", top)
	top.bg:SetFrameStrata("BACKGROUND")
	top.bg:SetAllPoints(top)
	top.bg:SetFrameLevel(0)
	top.gradient = top.bg:CreateTexture()
	top.gradient:SetTexture(blank)
	top.gradient:SetAllPoints(top)
	top.gradient:SetGradientAlpha("VERTICAL", .05, .05, .05, .8, .05, .05, .05, .3)

	top.shadow = CreateFrame("Frame", nil, top)
	top.shadow:SetPoint("TOPLEFT", -shadowsize, shadowsize)
	top.shadow:SetPoint("BOTTOMRIGHT", shadowsize, -shadowsize)
	top.shadow:SetBackdrop({
			edgeFile = glow,
			edgeSize = shadowsize,
	})
	top.shadow:SetBackdropBorderColor(.05, .05, .05, .9)
	
	local bar = {}
	for i = 1,8 do
		bar[i] = CreateFrame("Frame", "BottomInfoBar"..i, BottemInfoPanel)
		bar[i]:SetSize(80, 18)
--		bar[i]:SetBackdrop({
--			edgeFile = blank,
--			bgFile = blank,
--			edgeSize = bordersize,
--	})
--		bar[i]:SetBackdropBorderColor(.05, .05, .05, .9)
--		bar[i]:SetBackdropColor(0, 0, 0, 0)
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
		bar[i].Status:SetOrientation("VERTICAL")
		bar[i].Status:SetValue(100)	
		bar[i].Status:SetAlpha(0)
		
		bar[i].Text = bar[i]:CreateFontString(nil, "OVERLAY")
		bar[i].Text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
		bar[i].Text:SetPoint("CENTER", bar[i].Status, "CENTER", 0, 0)
	--	bar[i].Text:SetJustifyH("RIGHT")
		bar[i].Text:SetShadowColor(0, 0, 0, 0.4)
		bar[i].Text:SetShadowOffset(bordersize, -bordersize)
	end
--	CreateStat()
	SpawnBags(BottomInfoBar1,65)
	SpawnFriend(BottomInfoBar7,40)
	SpawnGuild(BottomInfoBar6,40)
	SpawnDurability(BottomInfoBar2,55)
	SpawnTalent(BottomInfoBar8,120)
	SpawnLatency(BottomInfoBar3,75)
	SpawnMemory(BottomInfoBar4,60)
	SpawnFPS(BottomInfoBar5,40)
end)