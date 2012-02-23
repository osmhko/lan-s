local addon, ns = ...
local lib = ns.lib
oUF.colors.smooth = {.7, .15, .15, .85, .8, .45, .15, .15, .15}
-----------------------------
-- STYLE FUNCTIONS
-----------------------------
local BarFader = function(self)
     if not Qulight["unitframes"].fade then return end
	self.BarFade = true
	self.BarFaderMinAlpha = "0"
end
local function CreatePlayerStyle(self, unit, isSingle)
	self.mystyle = "player"
	lib.init(self)
	BarFader(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(220,38)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_ppbar(self)
	lib.gen_RaidMark(self)
	lib.createDebuffs(self)
	if Qulight["unitframes"].showPlayerAuras then
		BuffFrame:Hide()
		lib.createBuffs(self)
	end
	self.Health.frequentUpdates = true
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	if Qulight["unitframes"].Powercolor then
	self.Power.colorClass = true
	else
	self.Power.colorPower = true
	end
	self.Power.frequentUpdates = true
	self.Power.bg.multiplier = 0.1
	if not Qulight["unitframes"].bigcastbar then
	lib.gen_castbar(self)
	else
	lib.gen_bigcastbar(self)
	end
	
	lib.gen_InfoIcons(self)
	
	lib.TotemBars(self)
	lib.Experience(self)
	lib.Reputation(self)
	lib.AltPowerBar(self)
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
	lib.ThreatBar(self)
	if Qulight["unitframes"].showRunebar then lib.genRunes(self) end
	if Qulight["unitframes"].showHolybar then lib.genHolyPower(self) end
	if Qulight["unitframes"].showShardbar then lib.genShards(self) end
	if Qulight["unitframes"].showEclipsebar then lib.addEclipseBar(self) end
end
local function CreateTargetStyle(self, unit, isSingle)
	self.mystyle = "target"
	lib.init(self)
--	BarFader(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(220,38)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_ppbar(self)
	lib.gen_RaidMark(self)
	
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	self.Power.colorTapping = true
	self.Power.colorDisconnected = true
	if Qulight["unitframes"].Powercolor then
	self.Power.colorClass = true
	else
	self.Power.colorPower = true
	end
	self.Power.colorReaction = true
	self.Power.bg.multiplier = 0.1
	if not Qulight["unitframes"].bigcastbar then
	lib.gen_castbar(self)
	else
	lib.gen_bigcastbar(self)
	end
	
	lib.addQuestIcon(self)
	lib.createAuras(self)
	lib.genCPoints(self)
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end	
end
local function CreateFocusStyle(self, unit, isSingle)
	self.mystyle = "focus"
	lib.init(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(180,34)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_ppbar(self)
	
	self.Power.colorTapping = true
	self.Power.colorDisconnected = true
	if Qulight["unitframes"].Powercolor then
	self.Power.colorClass = true
	else
	self.Power.colorPower = true
	end
	self.Power.colorReaction = true
	self.Power.colorHealth = true
	self.Power.bg.multiplier = 0.5
	lib.gen_RaidMark(self)
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	lib.gen_castbar(self)
	lib.createAuras(self)
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
local function CreateToTStyle(self, unit, isSingle)
	self.mystyle = "tot"
	lib.init(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(100,28)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	lib.createAuras(self)
	lib.gen_ppbar(self)
	self.Power.colorReaction = true
	self.Power.colorClass = true
	self.Power.colorHealth = true
	self.Power.bg.multiplier = 0.5
	self:SetParent("oUF_Target")
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end	
local function CreateFocusTargetStyle(self, unit, isSingle)
	self.mystyle = "focustarget"
	lib.init(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(100,28)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_ppbar(self)
	self.Power.colorClass = true
	self.Power.colorReaction = true
	self.Power.colorHealth = true
	self.Power.bg.multiplier = 0.5
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
local function CreatePetStyle(self, unit, isSingle)
	local _, playerClass = UnitClass("player")
	self.mystyle = "pet"
	lib.init(self)
	self.scale = scale
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(100,28)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_ppbar(self)
	self.Power.colorReaction = true
	self.Power.colorHealth = true
	self.Power.colorClass = true
	self.Power.bg.multiplier = 0.5
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	self:SetParent("oUF_Player")
	self.Health.frequentUpdates = false
	if PlayerClass == "HUNTER" then
		self.Power.colorReaction = false
		self.Power.colorClass = false
	end
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
local function CreateBossStyle(self, unit, isSingle)
	self.mystyle = "boss"
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(150,28)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	lib.gen_ppbar(self)
	self.Power.colorTapping = true
	self.Power.colorDisconnected = true
	self.Power.colorClass = true
	self.Power.colorReaction = true
	self.Power.colorHealth = true
	self.Power.bg.multiplier = 0.5
	lib.gen_castbar(self)
	
	lib.AltPowerBar(self)
	lib.createBuffs(self)
	lib.createDebuffs(self)
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
local function CreateMTStyle(self)
	self.mystyle = "oUF_MT"
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(100,22)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].HealthcolorClass then
	self.Health.colorClass = true
	end
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
local function CreateArenaStyle(self, unit, isSingle)
	self.mystyle = "oUF_Arena"
	self:SetScale(Qulight["unitframes"].SetScale)
	self:SetSize(150,28)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	lib.gen_highlight(self)
	lib.gen_RaidMark(self)
	lib.gen_ppbar(self)
	self.Power.colorTapping = true
	self.Power.colorDisconnected = true
	self.Power.colorClass = true
	self.Power.colorReaction = true
	self.Power.colorHealth = true
	self.Power.bg.multiplier = 0.5
	lib.gen_castbar(self)
	lib.createBuffs(self)
	lib.createDebuffs(self)
	self.Health.frequentUpdates = false
	if Qulight["unitframes"].showPortrait then lib.gen_portrait(self) end
end
-----------------------------
-- SPAWN UNITS
-----------------------------
oUF:RegisterStyle("Player", CreatePlayerStyle)
oUF:RegisterStyle("Target", CreateTargetStyle)
oUF:RegisterStyle("ToT", CreateToTStyle)
oUF:RegisterStyle("Focus", CreateFocusStyle)
oUF:RegisterStyle("FocusTarget", CreateFocusTargetStyle)
oUF:RegisterStyle("Pet", CreatePetStyle)
oUF:RegisterStyle("Boss", CreateBossStyle)
oUF:RegisterStyle("oUF_MT", CreateMTStyle)
oUF:RegisterStyle("oUF_Arena", CreateArenaStyle)

if not Qulight["unitframes"].enable == true then return end
oUF:Factory(function(self)
	self:SetActiveStyle("Player")
	local player = self:Spawn("player", "oUF_Player")
	player:SetPoint(unpack(Qulight["unitframes"].Anchorplayer))
	self:SetActiveStyle("Target")
	local target = self:Spawn("Target", "oUF_Target")
	target:SetPoint(unpack(Qulight["unitframes"].Anchortarget))
	if Qulight["unitframes"].showtot then
		self:SetActiveStyle("ToT")
		local targettarget = self:Spawn("targettarget", "oUF_tot")
		targettarget:SetPoint(unpack(Qulight["unitframes"].Anchortot))
	end
	if Qulight["unitframes"].showpet then
		self:SetActiveStyle("Pet")
		local pet = self:Spawn("pet", "oUF_pet")
		pet:SetPoint(unpack(Qulight["unitframes"].Anchorpet))
	end
	if Qulight["unitframes"].showfocus then 
		self:SetActiveStyle("Focus")
		local focus = self:Spawn("focus", "oUF_focus")
		focus:SetPoint(unpack(Qulight["unitframes"].Anchorfocus))
	end
	if Qulight["unitframes"].showfocustarget then 
		self:SetActiveStyle("FocusTarget")
		local focustarget = self:Spawn("focustarget", "oUF_focustarget")
		focustarget:SetPoint("LEFT", oUF_focus, "RIGHT", 8, -3)
	end
	
	if Qulight["unitframes"].MTFrames then
		oUF:SetActiveStyle("oUF_MT")
		local tank = oUF:SpawnHeader('oUF_MT', nil, 'raid',
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(80, 22),
			'showRaid', true,
			'groupFilter', 'MAINTANK',
			'yOffset', 8,
			'point' , 'BOTTOM',
			'template', 'oUF_MainTank')
		tank:SetPoint("TOP", Anchortank)
    end
	if Qulight["unitframes"].showBossFrames then
		self:SetActiveStyle("Boss")
		local boss = {}
			for i = 1, MAX_BOSS_FRAMES do
				boss[i] = self:Spawn("boss"..i, "oUF_Boss"..i)
				if i == 1 then
					boss[i]:SetPoint(unpack(Qulight["unitframes"].Anchorboss))
				else
					boss[i]:SetPoint("BOTTOMRIGHT", boss[i-1], "BOTTOMRIGHT", 0, 50)
			end
		end
	end
	oUF:SetActiveStyle("oUF_Arena")
	if Qulight["unitframes"].ArenaFrames then
	local arena = {}
	for i = 1, 5 do
		arena[i] = self:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			arena[i]:SetPoint("TOP", UIParent, "BOTTOM", 500, 550)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 35)
		end
		arena[i]:SetSize(150, 28)
	end	
	end
end)
local testui = TestUI or function() end
TestUI = function()
	testui()
	UnitAura = function()
		-- name, rank, texture, count, dtype, duration, timeLeft, caster
		return 'penancelol', 'Rank 2', 'Interface\\Icons\\Spell_Holy_Penance', random(5), 'Magic', 0, 0, "player"
	end
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if(v.UNIT_AURA) then
				v:UNIT_AURA("UNIT_AURA", v.unit)
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

PetCastingBarFrame:UnregisterAllEvents()
PetCastingBarFrame.Show = function() end
PetCastingBarFrame:Hide()

----------------------------------------------------------------------------------------
--	Testmode(by Fernir)
----------------------------------------------------------------------------------------
SlashCmdList.TESTUF = function()
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if not v.fff then
				v.fff = CreateFrame("Frame")
				CreateShadow(v.fff)
				v.fff:SetParent(UIParent)
				v.fff:SetFrameStrata("MEDIUM")
				v.fff:SetFrameLevel(0)
				v.fff:SetPoint("TOPLEFT", v, -2, 2)
				v.fff:SetPoint("BOTTOMRIGHT", v, 2, -2)
			
				v.fffs = SetFontString(v.fff, Qulight["media"].font, Qulight["media"].fontsize, "OUTLINE")
				v.fffs:SetShadowOffset(0, 0)
				v.fffs:SetAllPoints(v.fff)
				v.fffs:SetText(v:GetName())
			else
				if v.fff:IsShown() then 
					v.fff:Hide()
				else
					v.fff:Show()
				end
			end
		end
	end
end
SLASH_TESTUF1 = "/testuf"
SLASH_TESTUF2 = "/וףûודא"


do
	UnitPopupMenus["SELF"] = {  "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "SELECT_ROLE", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end