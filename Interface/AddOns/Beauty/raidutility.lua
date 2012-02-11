--Raid Utility by Elv22

local B, C = unpack(select(2, ...))

local load = CreateFrame("Frame")
load:RegisterEvent("ADDON_LOADED")
load:SetScript("OnEvent",function()
	local F, _ = unpack(Aurora)
	
	local panel_height = ((B.Scale(5)*5) + (B.Scale(20)*5))

	--Create main frame
	local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
	RaidUtilityPanel:SetFrameLevel(1)
	RaidUtilityPanel:SetHeight(panel_height)
	RaidUtilityPanel:Width(230)
	RaidUtilityPanel:SetFrameStrata("BACKGROUND")
	RaidUtilityPanel:Point("TOP", UIParent, "TOP", 0, 1)
	RaidUtilityPanel:SetFrameLevel(3)
	RaidUtilityPanel.toggled = false
	F.CreateBD(RaidUtilityPanel)
	F.CreateSD(RaidUtilityPanel)

	local function DisbandRaidGroup()
			if InCombatLockdown() then return end -- Prevent user error in combat
			
			SendChatMessage("正在解散队伍..", "RAID" or "PARTY")
			if UnitInRaid("player") then
				for i = 1, GetNumRaidMembers() do
					local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
					if online and name ~= B.myname then
						UninviteUnit(name)
					end
				end
			else
				for i = MAX_PARTY_MEMBERS, 1, -1 do
					if GetPartyMember(i) then
						UninviteUnit(UnitName("party"..i))
					end
				end
			end
			LeaveParty()
	end

	SlashCmdList["GROUPDISBAND"] = function()
		StaticPopup_Show("DISBAND_RAID")
	end
	SLASH_GROUPDISBAND1 = '/rd'

	StaticPopupDialogs["DISBAND_RAID"] = {
		text = "是否确定解散队伍?",
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = DisbandRaidGroup,
		timeout = 0,
		whileDead = 1,
	}

	--Check if We are Raid Leader or Raid Officer
	local function CheckRaidStatus()
		local inInstance, instanceType = IsInInstance()
		if ((GetNumPartyMembers() > 0 and not UnitInRaid("player")) or IsRaidLeader() or IsRaidOfficer()) and not (inInstance and (instanceType == "pvp" or instanceType == "arena")) then
			return true
		else
			return false
		end
	end

	--Change border when mouse is inside the button
	local function ButtonEnter(self)
		local color = RAID_CLASS_COLORS[B.myclass]
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	end

	--Change border back to normal when mouse leaves button
	local function ButtonLeave(self)
		self:SetBackdropBorderColor(unpack(C.bordercolor))
	end

	-- Function to create buttons in this module
	local function CreateButton(name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
		local b = CreateFrame("Button", name, parent, template)
		b:SetWidth(width)
		b:SetHeight(height)
		b:SetPoint(point, relativeto, point2, xOfs, yOfs)
		b:HookScript("OnEnter", ButtonEnter)
		b:HookScript("OnLeave", ButtonLeave)
		b:EnableMouse(true)
		b:CreateBorder()
		if text then
			local t = b:CreateFontString(nil,"OVERLAY",b)
			t:SetFont(C.font,14)
			t:SetPoint("CENTER")
			t:SetJustifyH("CENTER")
			t:SetText(text)
			b:SetFontString(t)
		elseif texture then
			local t = b:CreateTexture(nil,"OVERLAY",nil)
			t:SetTexture(texture)
			t:SetPoint("TOPLEFT", b, "TOPLEFT", B.mult, -B.mult)
			t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -B.mult, B.mult)	
		end
		b:SetFrameStrata("HIGH")
	end

	--Show Button
	CreateButton("ShowButton", UIParent, "UIMenuButtonStretchTemplate, SecureHandlerClickTemplate", 80, 18, "TOP", UIParent, "TOP", 0, 2, "团队工具", nil)
	ShowButton:SetFrameRef("RaidUtilityPanel", RaidUtilityPanel)
	ShowButton:SetAttribute("_onclick", [=[self:Hide(); self:GetFrameRef("RaidUtilityPanel"):Show();]=])
	ShowButton:SetScript("OnMouseUp", function(self) RaidUtilityPanel.toggled = true end)

	--Close Button
	CreateButton("CloseButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate, SecureHandlerClickTemplate", 80, 18, "TOP", RaidUtilityPanel, "BOTTOM", 0, -1, CLOSE, nil)
	CloseButton:SetFrameRef("ShowButton", ShowButton)
	CloseButton:SetAttribute("_onclick", [=[self:GetParent():Hide(); self:GetFrameRef("ShowButton"):Show();]=])
	CloseButton:SetScript("OnMouseUp", function(self) RaidUtilityPanel.toggled = false end)

	--Disband Raid button
	CreateButton("DisbandRaidButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RaidUtilityPanel:GetWidth() * 0.8, B.Scale(18), "TOP", RaidUtilityPanel, "TOP", 0, B.Scale(-5), "解散队伍", nil)
	DisbandRaidButton:SetScript("OnMouseUp", function(self)
		if CheckRaidStatus() then
			StaticPopup_Show("DISBAND_RAID")
		end
	end)

	--Role Check button
	CreateButton("RoleCheckButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RaidUtilityPanel:GetWidth() * 0.8, B.Scale(18), "TOP", DisbandRaidButton, "BOTTOM", 0, B.Scale(-5), ROLE_POLL, nil)
	RoleCheckButton:SetScript("OnMouseUp", function(self)
		if CheckRaidStatus() then
			InitiateRolePoll()
		end
	end)

	--MainTank Button
	CreateButton("MainTankButton", RaidUtilityPanel, "SecureActionButtonTemplate, UIMenuButtonStretchTemplate", (DisbandRaidButton:GetWidth() / 2) - B.Scale(2), B.Scale(18), "TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, B.Scale(-5), MAINTANK, nil)
	MainTankButton:SetAttribute("type", "maintank")
	MainTankButton:SetAttribute("unit", "target")
	MainTankButton:SetAttribute("action", "toggle")

	--MainAssist Button
	CreateButton("MainAssistButton", RaidUtilityPanel, "SecureActionButtonTemplate, UIMenuButtonStretchTemplate", (DisbandRaidButton:GetWidth() / 2) - B.Scale(2), B.Scale(18), "TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, B.Scale(-5), MAINASSIST, nil)
	MainAssistButton:SetAttribute("type", "mainassist")
	MainAssistButton:SetAttribute("unit", "target")
	MainAssistButton:SetAttribute("action", "toggle")

	--Ready Check button
	CreateButton("ReadyCheckButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RoleCheckButton:GetWidth() * 0.75, B.Scale(18), "TOPLEFT", MainTankButton, "BOTTOMLEFT", 0, B.Scale(-5), READY_CHECK, nil)
	ReadyCheckButton:SetScript("OnMouseUp", function(self)
		if CheckRaidStatus() then
			DoReadyCheck()
		end
	end)

	--Reposition/Resize and Reuse the World Marker Button
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:ClearAllPoints()
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetPoint("TOPRIGHT", MainAssistButton, "BOTTOMRIGHT", 0, B.Scale(-5))
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetParent("RaidUtilityPanel")
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetHeight(B.Scale(18))
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetWidth(RoleCheckButton:GetWidth() * 0.22)

	--Put other stuff back
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:ClearAllPoints()
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:SetPoint("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLockedModeToggle, "TOPLEFT", 0, 1)
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:SetPoint("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameHiddenModeToggle, "TOPRIGHT", 0, 1)

	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:ClearAllPoints()
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:SetPoint("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPLEFT", 0, 1)
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:SetPoint("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPRIGHT", 0, 1)

	--Raid Control Panel
	CreateButton("RaidControlButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RoleCheckButton:GetWidth(), B.Scale(18), "TOPLEFT", ReadyCheckButton, "BOTTOMLEFT", 0, B.Scale(-5), RAID_CONTROL, nil)
	RaidControlButton:SetScript("OnMouseUp", function(self)
		ToggleFriendsFrame(4)
	end)

	--Reskin Stuff
	do
		local buttons = {
			"CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton",
			"DisbandRaidButton",
			"MainTankButton",
			"MainAssistButton",
			"RoleCheckButton",
			"ReadyCheckButton",
			"RaidControlButton",
			"ShowButton",
			"CloseButton"
		}
		CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton.SetNormalTexture = function() end
		CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton.SetPushedTexture = function() end
		for i, button in pairs(buttons) do
			local f = _G[button]
			F.Reskin(f)
		end
	end


	local function ToggleRaidUtil(self, event)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			return
		end
		
		if CheckRaidStatus() then
			if RaidUtilityPanel.toggled == true then
				ShowButton:Hide()
				RaidUtilityPanel:Show()		
			else
				ShowButton:Show()
				RaidUtilityPanel:Hide()
			end
		else
			ShowButton:Hide()
			RaidUtilityPanel:Hide()
		end
		
		if event == "PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end
	end

	--Automatically show/hide the frame if we have RaidLeader or RaidOfficer
	local LeadershipCheck = CreateFrame("Frame")
	LeadershipCheck:RegisterEvent("RAID_ROSTER_UPDATE")
	LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
	LeadershipCheck:RegisterEvent("PARTY_MEMBERS_CHANGED")
	LeadershipCheck:SetScript("OnEvent", ToggleRaidUtil)

end)