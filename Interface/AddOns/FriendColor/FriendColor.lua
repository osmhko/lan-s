function Hook_FriendsList_Update()
	local friendOffset = FriendsFrame_GetTopButton(FriendsFrameFriendsScrollFrameScrollBar:GetValue());
	if not friendOffset then
		return;
	end
	if friendOffset < 0 then
		friendOffset = 0;
	end

	local numBNetTotal, numBNetOnline = BNGetNumFriends();
	if numBNetOnline > 0 then
		for i=1, numBNetOnline, 1 do
			local presenceID, givenName, surname, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, broadcastText, noteText, isFriend, broadcastTime = BNGetFriendInfo(i);
			if client == BNET_CLIENT_WOW then
				local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(toonID);
				local derp = class;
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				if GetLocale() ~= "enUS" then
					for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
				end
				local classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
				if not classc then
					return;
				end
				local nameString = _G["FriendsFrameFriendsScrollFrameButton"..(i-friendOffset).."Name"];
				if nameString then
					nameString:SetText(surname.." "..givenName.." ("..toonName..", L"..level.." "..derp..")");
					nameString:SetTextColor(classc.r, classc.g, classc.b);
				end
				if CanCooperateWithToon(toonID) ~= true then
					local nameString = _G["FriendsFrameFriendsScrollFrameButton"..(i-friendOffset).."Info"];
					if nameString then
						nameString:SetText(zoneName.." ("..realmName..")");
					end
				end
			end
		end
	end

	local numberOfFriends, onlineFriends = GetNumFriends();
	if onlineFriends > 0 then
		for i=1, onlineFriends, 1 do
			j = i + numBNetOnline;
			local name, level, class, area, connected, status, note, RAF = GetFriendInfo(i);
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			if GetLocale() ~= "enUS" then
				for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
			end
			local classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
			if not classc then
				return;
			end
			if connected then
				local nameString = _G["FriendsFrameFriendsScrollFrameButton"..(j-friendOffset).."Name"];
				if nameString then
					nameString:SetTextColor(classc.r, classc.g, classc.b);
				end
			end
		end
	end
end;
hooksecurefunc("FriendsList_Update", Hook_FriendsList_Update);
hooksecurefunc("HybridScrollFrame_Update", Hook_FriendsList_Update);
