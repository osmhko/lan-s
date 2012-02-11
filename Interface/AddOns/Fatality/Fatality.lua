------------------------------------------------------------------------------
--								CONFIGURATION								--
------------------------------------------------------------------------------
-- Fatality is no longer configurable via Lua. In future, after you have	--
-- set it up once in-game, you will not need to manually edit this file or	--
-- re-configure it after updates.											--
------------------------------------------------------------------------------
--		Type "/fatality list" in-game for a full list of options.			--
------------------------------------------------------------------------------

local Fatality = CreateFrame("frame")
local option, death, unknown = "|cff3399FF%s|r set to |cff99FFCC%s|r", "Fatality: %s > %s", "Fatality: %s%s > Unknown"
local max_limit = "|cffffff00(%s) Report cannot be sent because it exceeds the maximum character limit of 255. To fix this, set \"/fat history\" to a smaller number.|r"
local special = { ["SPELL_DAMAGE"] = true, ["SPELL_PERIODIC_DAMAGE"] = true, ["RANGE_DAMAGE"] = true }
local candidates, units = {}, {}
local count, history = 0, 0
local channel_id, party_channel_id
local instanceType, difficulty, limit
local on_off = { [true] = "|cff00ff00on|r", [false] = "|cffff0000off|r"}

-- Upvalues
local UnitInRaid, UnitInParty, UnitIsDead, UnitIsFeignDeath = UnitInRaid, UnitInParty, UnitIsDead, UnitIsFeignDeath
local UnitClass, UnitGUID, UnitName, UnitExists = UnitClass, UnitGUID, UnitName, UnitExists
local GetTime, format, wipe, type, band, match, find = GetTime, string.format, wipe, type, bit.band, string.match, string.find

Fatality:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local rt, path = "{rt%d}", "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d.blp:0|t"
local rt1, rtmask = COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET_MASK

local function printf(s,...)
	print("|cff39d7e5Fatality:|r " .. s:format(...))
end

local function icon(flag)
	if not FatalityDB.icons then return "" end
	local number, mask, mark
	if band(flag, rtmask) ~= 0 then
		for i=1,8 do
			mask = rt1 * (2 ^ (i - 1))
			mark = band(flag, mask) == mask
			if mark then number = i break end
		end
	end
	return number and ((FatalityDB.output1 == "SELF" or (instanceType == "party" and FatalityDB.output2 =="SELF")) and format(path, number) or format(rt, number)) or ""
end

local function shorten(n)
	if not (FatalityDB.short and type(n) == "number") then return n end
	if n >= 10000000 then
		return format("%.1fM", n/1000000)
	elseif n >= 1000000 then
		return format("%.2fM", n/1000000)
	elseif n >= 100000 then
		return format("%.fk", n/1000)
	elseif n >= 1000 then
		return format("%.1fk", n/1000)
	else
		return n
	end
end

local function color(name)
	if FatalityDB.output1 ~= "SELF" or (instanceType == "party" and FatalityDB.output2 ~= "SELF") then return name end
	if not UnitExists(name) then return format("|cffff0000%s|r", name) end
	local _, class = UnitClass(name)
	local color = _G["RAID_CLASS_COLORS"][class]
	return format("|cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, name)
end

local function send(message)
	if instanceType == "raid" then
		if FatalityDB.output1 == "SELF" then
			print(message)
		else
			SendChatMessage(message, FatalityDB.output1, nil, channel_id)
		end
	elseif instanceType == "party" and FatalityDB.party then
		if FatalityDB.output2 == "SELF" then
			print(message)
		else
			SendChatMessage(message, FatalityDB.output2, nil, party_channel_id)
		end
	end
end

local function shuffle(t)
    for i=1,#t-1 do
	    t[i].time = t[i+1].time
		t[i].srcGUID = t[i+1].srcGUID
		t[i].srcName = t[i+1].srcName
		t[i].srcRaidFlags = t[i+1].srcRaidFlags
		t[i].destGUID = t[i+1].destGUID 	
		t[i].destName = t[i+1].destName 	
		t[i].destRaidFlags = t[i+1].destRaidFlags 	
		t[i].spellID = t[i+1].spellID 	
		t[i].spellName = t[i+1].spellName 	
		t[i].environment = t[i+1].environment
		t[i].amount = t[i+1].amount 	
		t[i].overkill = t[i+1].overkill 	
		t[i].crit = t[i+1].crit 			
    end
end

local function strip(name)
	if not UnitInParty(name) then return name end
	return match(name ,"[^-]*")
end

function Fatality:FormatOutput(guid, known)
	
	local c = candidates[guid]
	local destName, destRaidFlags = strip(c[#c].destName), c[#c].destRaidFlags
		
	local destIcon = icon(destRaidFlags)
	
	if not known then
		return unknown:format(destIcon, destName)
	end
	
	local dest = format("%s%s", destIcon, color(strip(c[1].destName)))
	
	local source, info, full
	
	for i=1,self.db.history do
	
		local e = c[i]
		
		if not e then break end
		
		if e.srcName then
			local srcIcon = icon(e.srcRaidFlags)
			e.srcName = strip(e.srcName)
			source = format("%s%s", srcIcon, color(e.srcName))
		else
			source = color("Unknown")
		end
		
		local ability = (e.spellID and GetSpellLink(e.spellID)) or e.environment or "Melee"
		
		if e.amount > 0 then
			local amount = (self.db.overkill and (e.amount - e.overkill)) or e.amount
			local overkill = (self.db.overkill and e.overkill > 0) and format(" (O: %s)", shorten(e.overkill)) or ""
			amount = shorten(amount)
			if not e.environment then
				local crit_crush = (e.crit and " (Critical)") or ""
				-- SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE, RANGE_DAMAGE, SWING_DAMAGE
				info = format("%s %s%s%s [%s]", amount, ability, overkill, crit_crush, source)
			else
				-- ENVIRONMENTAL_DAMAGE
				info = format("%s %s [%s]", amount, ability, source)
			end
		else
			-- SPELL_INSTAKILL
			info = format("%s [%s]", ability, color("Unknown"))
		end
		
		full = format("%s%s%s", full or "", info, c[i+1] and " + " or "")
		
	end
	
	local msg = format(death, dest, full)

	if msg:len() > 255 and (self.db.output1 ~= "SELF" or (instanceType == "party" and self.db.output2 ~="SELF"))  then
		local err = format(max_limit, destName)
		printf("%s", err)
		return
	end
	
	return msg
	
end

function Fatality:RecordDamage(now, srcGUID, srcName, srcRaidFlags, destGUID, destName, destRaidFlags, spellID, spellName, environment, amount, overkill, crit)
	
	-- If the table doesn't already exist, create it
	if not candidates[destGUID] then
		candidates[destGUID] = {}
	end
	
	-- Store the table in a temporary variable
	local t = candidates[destGUID]

	if self.db.history == 1 then
		history = 1
	elseif #t < self.db.history then
        history = #t + 1
    else
        shuffle(t)
        history = self.db.history
    end
	
	if not t[history] then
		t[history] = {}
	end
	
	t[history].time = now
    t[history].srcGUID = srcGUID
	t[history].srcName = srcName
	t[history].srcRaidFlags = srcRaidFlags
	t[history].destGUID = destGUID
	t[history].destName = destName
	t[history].destRaidFlags = destRaidFlags
	t[history].spellID = spellID
	t[history].spellName = spellName
	t[history].environment = environment
	t[history].amount = amount
	t[history].overkill = overkill
	t[history].crit = crit
	
end

function Fatality:ReportDeath(guid)
	if not candidates[guid] then return end
	local report, now, candidate = "", GetTime(), candidates[guid]
	local id = candidate[1].destGUID
	if candidate and count < limit then
		-- If the last damage event is more than 2 seconds before
		-- UNIT_DIED fired, assume the cause of death is unknown
		if (now - candidate[#candidate].time) < 2 then
			report = self:FormatOutput(id, true)
		else
			report = self:FormatOutput(id)
		end
		send(report)
		count = count + 1
		candidates[guid] = nil
	end
end

function Fatality:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	
	if not (UnitInRaid(destName) or UnitInParty(destName)) then return end
	
	local spellID, spellName, amount, overkill, environment, crit
	
	if special[event] then
		spellID, spellName, spellSchool, amount, overkill, _, _, _, _, crit = ...
	elseif event == "SWING_DAMAGE" then
		amount, overkill, _, _, _, _, crit = ...
	elseif event == "SPELL_INSTAKILL" then
		spellID = ...
		amount = -1
	elseif event == "ENVIRONMENTAL_DAMAGE" then
		environment, amount, overkill = ...
	end
	
	if amount and (amount >= self.db.threshold or amount == -1) then
		self:RecordDamage(GetTime(), srcGUID, srcName, srcRaidFlags, destGUID, destName, destRaidFlags, spellID, spellName, environment, amount, overkill, crit)
	end
	
	if event == "UNIT_DIED" and not UnitIsFeignDeath(destName) then
		self:ReportDeath(destGUID)
	end
	
end

function Fatality:ClearData()
	count = 0
	wipe(units)
	wipe(candidates)
end

function Fatality:RegisterEvents()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	channel_id = GetChannelName(self.db.channel1)
	party_channel_id = GetChannelName(self.db.channel2)
end

function Fatality:UnregisterEvents()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
end

function Fatality:CheckEnable()
	if not self.db.enabled then return end
	instanceType = select(2, IsInInstance())
	if instanceType == "raid" or (self.db.party and instanceType == "party") then
		difficulty = GetInstanceDifficulty()
		limit = (difficulty == 1 or difficulty == 3) and self.db.limit10 or self.db.limit25
		self:ClearData()
		self:RegisterEvents()
	else
		self:UnregisterEvents()
	end
end

function Fatality:PLAYER_REGEN_DISABLED()
	self:ClearData()
end


function Fatality:PLAYER_LOGIN()
	self:CheckEnable()
end

function Fatality:ZONE_CHANGED()
	self:CheckEnable()
end

function Fatality:ZONE_CHANGED_NEW_AREA()
	self:CheckEnable()
end

function Fatality:PLAYER_ENTERING_WORLD()
	self:CheckEnable()
end

function Fatality:PrintCommands()
	printf("%s", "Command List")
	print("     |cff3399FFlist|r displays this list")
	print("  |cffFFFF99e.g. |cffFF9933/fat party|r |cffFFFF99to toggle...|r")
	print("     |cff3399FFparty|r [|cff99FFCC" .. on_off[self.db.party] .. "|r] Should announcements be sent while in Party instances?")
	print("     |cff3399FFoverkill|r [|cff99FFCC" .. on_off[self.db.overkill] .. "|r] Should overkill be reported?")
	print("     |cff3399FFicons|r [|cff99FFCC" .. on_off[self.db.icons] .. "|r] Should raid icons be shown?")
	print("     |cff3399FFshort|r [|cff99FFCC" .. on_off[self.db.short] .. "|r] Should numbers be shortened? i.e. 9431 = 9.4k")
	print("  |cffFFFF99e.g.|r |cffFF9933/fat history 2|r |cffFFFF99to set...|r")
	print("     |cff3399FFlimit10|r [|cff99FFCC" .. self.db.limit10 .. "|r] How many deaths should be reported per combat session? (10 man)")
	print("     |cff3399FFlimit25|r [|cff99FFCC" .. self.db.limit25 .. "|r] How many deaths should be reported per combat session? (25 man)")
	print("     |cff3399FFhistory|r [|cff99FFCC" .. self.db.history .. "|r] How many damage events should be reported per person?")
	print("     |cff3399FFthreshold|r [|cff99FFCC" .. self.db.threshold .. "|r] What should be the minimum amount of damage recorded?")
	print("     |cff3399FFoutput1|r [|cff99FFCC" .. self.db.output1 .. "|r] Where should Raid instance announcements be sent?")
	print("     |cff3399FFchannel1|r [|cff99FFCC" .. self.db.channel1 .. "|r] For private channels (Raid), set |cff3399FFoutput1|r to |cff99FFCCCHANNEL|r")
	print("     |cff3399FFoutput2|r [|cff99FFCC" .. self.db.output2 .. "|r] Where should Party instance announcements be sent?")
	print("     |cff3399FFchannel2|r [|cff99FFCC" .. self.db.channel2 .. "|r] For private channels (Party), set |cff3399FFoutput2|r to |cff99FFCCCHANNEL|r")
end

function Fatality:CreateSlashCommands()
	SLASH_FATALITY1, SLASH_FATALITY2 = "/fatality", "/fat"
	SlashCmdList.FATALITY = function(msg)
		
		local cmd, arg = string.split(" ", msg, 2)
		cmd = string.lower(cmd or "")
		arg = arg or ""
	
		if cmd == "" then
			if self.db.enabled then
				self:UnregisterEvents()
				self.db.enabled = false
				printf("%s", on_off[self.db.enabled])
			else
				self:RegisterEvents()
				self.db.enabled = true
				printf("%s", on_off[self.db.enabled])
			end
		elseif cmd == "overkill" then
			self.db.overkill = not self.db.overkill
			printf(option, "overkill", on_off[self.db.overkill])
		elseif cmd == "icons" then
			self.db.icons = not self.db.icons
			printf(option, "raid icons", on_off[self.db.icons])
		elseif cmd == "short" then
			self.db.short = not self.db.short
			printf(option, "short numbers", on_off[self.db.short])
		elseif cmd == "party" then
			self.db.party = not self.db.party
			printf(option, "party instances", on_off[self.db.party])
		else
			if arg ~= "" then
				if cmd == "limit10" then
					self.db.limit10 = tonumber(arg)
					printf(option, cmd, arg)
				elseif cmd == "limit25" then
					self.db.limit25 = tonumber(arg)
					printf(option, cmd, arg)
				elseif cmd == "threshold" then
					self.db.threshold = tonumber(arg)
					printf(option, cmd, arg)
				elseif cmd == "history" then
					self.db.history = tonumber(arg)
					printf(option, "event history", arg)
				elseif cmd == "output1" then
					self.db.output1 = arg:upper()
					printf(option, "output [raid]", arg)
				elseif cmd == "channel1" then
					self.db.channel1 = arg
					printf(option, "channel [raid]", arg)
				elseif cmd == "output2" then
					self.db.output2 = arg:upper()
					printf(option, "output [party]", arg)
				elseif cmd == "channel2" then
					self.db.channel2 = arg
					printf(option, "channel [party]", arg)
				else
					self:PrintCommands()
				end
			else
				if self.db[cmd] then
					printf(option, cmd, self.db[cmd])
				else
					self:PrintCommands()
				end
			end			
		end
		self:CheckEnable()
	end
end

function Fatality:ADDON_LOADED(addon)

	if addon ~= "Fatality" then return end
	
	local defaults = {
		enabled = true,
		party = true,
		overkill = true,
		short = true,
		icons = true,
		limit10 = 5,
		limit25 = 10,
		output1 = "RAID",
		channel1 = "FatalityReports",
		output2 = "PARTY",		
		channel2 = "FatalityReports",
		history = 1,
		threshold = 0,
	}
	
	FatalityDB = FatalityDB or {}
	
	for k,v in pairs(defaults) do
		if FatalityDB[k] == nil then
			FatalityDB[k] = v
		end
	end
	
	self.db = FatalityDB
	
	self:CreateSlashCommands()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
end

Fatality:RegisterEvent("ADDON_LOADED")