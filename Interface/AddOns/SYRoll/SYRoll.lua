------------------------------------------------------------------------------
-- Credit Tekkub, Ray
------------------------------------------------------------------------------
-- CONFIG --------------------------------------------------------------------
------------------------------------------------------------------------------
local mode = 0						--0为阴影模式 1为1像素模式
local font = "Fonts\\Zykai_T.ttf"	--字体
local fontsize = 14					--字号
local fontflag = "THINOUTLINE"		--描边
local buttonsize = 22				--图标大小
local barw, barh = 326, 5			--条大小
local barspacing = 4				--间距
local fscale = 1					--缩放

local myname, ns = ...

local blank = "Interface\\AddOns\\SYRoll\\media\\blank"
local normal = "Interface\\AddOns\\SYRoll\\media\\statusbar"
local glow = "Interface\\AddOns\\SYRoll\\media\\glow"
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/0.78

local function scale(x)
	return mult*math.floor(x/mult+0.5)
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = scale(arg1) end
	if type(arg2)=="number" then arg2 = scale(arg2) end
	if type(arg3)=="number" then arg3 = scale(arg3) end
	if type(arg4)=="number" then arg4 = scale(arg4) end
	if type(arg5)=="number" then arg5 = scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function Width(frame, width)
	frame:SetWidth(scale(width))
end

local function Height(frame, height)
	frame:SetHeight(scale(height))
end

local function CreateBorder(f, r, g, b, a)
	f:SetBackdrop({
		edgeFile = blank, 
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	})
	f:SetBackdropBorderColor(0,0,0,1)
end

local function CreateShadow(f, t, offset, thickness, texture)
	if f.shadow then return end
	
	local borderr, borderg, borderb, bordera = 0,0,0,1
	local backdropr, backdropg, backdropb, backdropa = .05,.05,.05,.6
	
	local border = CreateFrame("Frame", nil, f)
	border:SetFrameLevel(1)
	Point(border,"TOPLEFT", -1, 1)
	Point(border,"TOPRIGHT", 1, 1)
	Point(border,"BOTTOMRIGHT", 1, -1)
	Point(border,"BOTTOMLEFT", -1, -1)
	CreateBorder(border)
	f.border = border
	
	if mode == 0 then
		local shadow = CreateFrame("Frame", nil, border)
		shadow:SetFrameLevel(0)
		Point(shadow,"TOPLEFT", -3, 3)
		Point(shadow,"TOPRIGHT", 3, 3)
		Point(shadow,"BOTTOMRIGHT", 3, -3)
		Point(shadow,"BOTTOMLEFT", -3, -3)
		shadow:SetBackdrop( { 
			edgeFile = glow,
			bgFile = blank,
			edgeSize = scale(4),
			insets = {left = scale(4), right = scale(4), top = scale(4), bottom = scale(4)},
		})
		shadow:SetBackdropColor( backdropr, backdropg, backdropb, backdropa )
		shadow:SetBackdropBorderColor( borderr, borderg, borderb, bordera )
		f.shadow = shadow
	end
end

local backdrop = {
	bgFile = "", tile = true, tileSize = 0,
	edgeFile = blank, edgeSize = mult,
	insets = {left = -mult, right = -mult, top = -mult, bottom = -mult},
}


local function ClickRoll(frame)
	RollOnLoot(frame.parent.rollid, frame.rolltype)
end


local function HideTip() GameTooltip:Hide() end
local function HideTip2() GameTooltip:Hide(); ResetCursor() end


local rolltypes = {"need", "greed", "disenchant", [0] = "pass"}
local function SetTip(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:SetText(frame.tiptext)
	if frame:IsEnabled() == 0 then 
		GameTooltip:AddLine("|cffff3333Cannot roll") 
	end
	for name,roll in pairs(frame.parent.rolls) do if roll == rolltypes[frame.rolltype] then GameTooltip:AddLine(name, 1, 1, 1) end end
	GameTooltip:Show()
end

local function SetItemTip(frame)
	if not frame.link then return end
	GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(frame.link)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	if IsModifiedClick("DRESSUP") then ShowInspectCursor() else ResetCursor() end
end


local function ItemOnUpdate(self)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	CursorOnUpdate(self)
end


local function LootClick(frame)
	if IsControlKeyDown() then DressUpItemLink(frame.link)
	elseif IsShiftKeyDown() then ChatEdit_InsertLink(frame.link) end
end


local cancelled_rolls = {}
local function OnEvent(frame, event, rollid)
	cancelled_rolls[rollid] = true
	if frame.rollid ~= rollid then return end

	frame.rollid = nil
	frame.time = nil
	frame:Hide()
end


local function StatusUpdate(frame)
	local t = GetLootRollTimeLeft(frame.parent.rollid)
	local perc = t / frame.parent.time
	frame.spark:SetPoint("CENTER", frame, "LEFT", perc * frame:GetWidth(), 0)
	frame:SetValue(t)
end


local function CreateRollButton(parent, ntex, ptex, htex, rolltype, tiptext, ...)
	local f = CreateFrame("Button", nil, parent)
	f:SetPoint(...)
	Width(f,28)
	Height(f,28)
	f:SetNormalTexture(ntex)
	if ptex then f:SetPushedTexture(ptex) end
	f:SetHighlightTexture(htex)
	f.rolltype = rolltype
	f.parent = parent
	f.tiptext = tiptext
	f:SetScript("OnEnter", SetTip)
	f:SetScript("OnLeave", HideTip)
	f:SetScript("OnClick", ClickRoll)
	f:SetScript("OnUpdate", SetButtonAlpha)
	f:SetMotionScriptsWhileDisabled(true)
	local txt = f:CreateFontString(nil, nil)
	txt:SetFont(font, fontsize, fontflag)
	Point(txt,"CENTER", 0, rolltype == 2 and 1 or rolltype == 0 and -1.2 or 0)
	return f, txt
end

local function CreateRollFrame()
	local frame = CreateFrame("Frame", nil, UIParent)
	Width(frame,barw+2+buttonsize)
	Height(frame,buttonsize)
	frame:SetScale(fscale)
	--frame:SetBackdrop(backdrop)
	frame:SetBackdropColor(0, 0, 0, .9)
	frame:SetScript("OnEvent", OnEvent)
	frame:RegisterEvent("CANCEL_LOOT_ROLL")
	frame:Hide()

	local button = CreateFrame("Button", nil, frame)
	Point(button,"LEFT", -buttonsize-2, 0)
	Width(button,buttonsize)
	Height(button,buttonsize)
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", HideTip2)
	button:SetScript("OnUpdate", ItemOnUpdate)
	button:SetScript("OnClick", LootClick)
	frame.button = button

	local buttonborder = CreateFrame("Frame", nil, button)
	Width(buttonborder,buttonsize)
	Height(buttonborder,buttonsize)
	buttonborder:SetPoint("CENTER", button, "CENTER")
	--buttonborder:SetBackdrop(backdrop)
	buttonborder:SetBackdropColor(1,1,1,0)
	
	local buttonborder2 = CreateFrame("Frame", nil, button)
	Width(buttonborder2,buttonsize)
	Height(buttonborder2,buttonsize)
	buttonborder2:SetFrameLevel(buttonborder:GetFrameLevel()+1)
	buttonborder2:SetPoint("CENTER", button, "CENTER")
	CreateShadow(buttonborder2)
	if mode == 0 then 
		buttonborder2.shadow:SetFrameStrata("BACKGROUND")
		buttonborder2.shadow:SetFrameLevel(0)
	end
	buttonborder2:SetBackdropColor(0, 0, 0, 0)
	buttonborder2:SetBackdropBorderColor(0, 0, 0, 1)
	frame.buttonborder = buttonborder

	local tfade = frame:CreateTexture(nil, "BORDER")
	tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
	tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
	tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	tfade:SetBlendMode("ADD")
	tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 0)

	local status = CreateFrame("StatusBar", nil, frame)
	Width(status,barw)
	Height(status,barh)
	status:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 0)
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetFrameLevel(status:GetFrameLevel()-1)
	status:SetStatusBarTexture(normal)
	status:SetStatusBarColor(.8, .8, .8, .9)
	CreateShadow(status)
	status.parent = frame
	frame.status = status

	local spark = frame:CreateTexture(nil, "OVERLAY")
	spark:SetWidth(14)
	spark:SetHeight(25)
	spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	spark:SetBlendMode("ADD")
	status.spark = spark

	local need, needtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "BOTTOMLEFT", frame.status, "BOTTOMLEFT", scale(5), scale(-3))
	local greed, greedtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 0, scale(-1))
	local de, detext
	de, detext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", 0, scale(1))
	local pass, passtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "LEFT", de or greed, "RIGHT", 0, scale(1.4))
	frame.needbutt, frame.greedbutt, frame.disenchantbutt = need, greed, de
	frame.need, frame.greed, frame.pass, frame.disenchant = needtext, greedtext, passtext, detext

	local bind = frame:CreateFontString()
	bind:SetPoint("LEFT", pass, "RIGHT", scale(3), scale(-1))
	bind:SetFont(font, fontsize, fontflag)
	frame.fsbind = bind

	local loot = frame:CreateFontString(nil, "ARTWORK")
	loot:SetFont(font, fontsize, fontflag)
	loot:SetPoint("LEFT", bind, "RIGHT", 0, scale(0.12))
	loot:SetPoint("RIGHT", frame, "RIGHT", scale(-5), 0)
	Height(loot,10)
	Width(loot,200)
	loot:SetJustifyH("LEFT")
	frame.fsloot = loot

	frame.rolls = {}

	return frame
end


local anchor = CreateFrame("Button", nil, UIParent)
Width(anchor,350)
Height(anchor,buttonsize)
anchor:SetBackdrop(backdrop)
anchor:SetBackdropColor(0.25, 0.25, 0.25, 1)
local label = anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
label:SetAllPoints(anchor)
label:SetText("SYRoll")

anchor:SetScript("OnClick", anchor.Hide)
anchor:SetScript("OnDragStart", anchor.StartMoving)
anchor:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	self.db.x, self.db.y = self:GetCenter()
end)
anchor:SetMovable(true)
anchor:EnableMouse(true)
anchor:RegisterForDrag("LeftButton")
anchor:RegisterForClicks("RightButtonUp")
anchor:Hide()

local frames = {}

local f = CreateRollFrame() -- Create one for good measure
f:SetPoint("TOPLEFT", next(frames) and frames[#frames] or anchor, "BOTTOMLEFT", 0, -scale(barspacing))
table.insert(frames, f)

local function GetFrame()
	for i,f in ipairs(frames) do
		if not f.rollid then return f end
	end

	local f = CreateRollFrame()
	f:SetPoint("TOPLEFT", next(frames) and frames[#frames] or anchor, "BOTTOMLEFT", 0, -scale(barspacing))
	table.insert(frames, f)
	return f
end


local function START_LOOT_ROLL(rollid, time)
	if cancelled_rolls[rollid] then return end

	local f = GetFrame()
	f.rollid = rollid
	f.time = time
	for i in pairs(f.rolls) do f.rolls[i] = nil end
	f.need:SetText(0)
	f.greed:SetText(0)
	f.pass:SetText(0)
	f.disenchant:SetText(0)

	local texture, name, count, quality, bop, canNeed, canGreed, canDisenchant = GetLootRollItemInfo(rollid)
	f.button:SetNormalTexture(texture)
	f.button:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
	f.button.link = GetLootRollItemLink(rollid)

--	if canNeed then f.needbutt:Enable() else f.needbutt:Disable() end
--	if canGreed then f.greedbutt:Enable() else f.greedbutt:Disable() end
--	if canDisenchant then f.disenchantbutt:Enable() else f.disenchantbutt:Disable() end
--	if canNeed then f.needbutt:Enable() else f.needbutt:SetAlpha(0.5) end
--	if canGreed then f.greedbutt:Enable() else f.greedbutt:SetAlpha(0.5) end
--	if canDisenchant then f.disenchantbutt:Enable() else f.disenchantbutt:SetAlpha(0.5) end
	if canNeed then GroupLootFrame_EnableLootButton(f.needbutt) else GroupLootFrame_DisableLootButton(f.needbutt) end
	if canGreed then GroupLootFrame_EnableLootButton(f.greedbutt) else GroupLootFrame_DisableLootButton(f.greedbutt) end
	if canDisenchant then GroupLootFrame_EnableLootButton(f.disenchantbutt) else GroupLootFrame_DisableLootButton(f.disenchantbutt) end


	SetDesaturation(f.needbutt:GetNormalTexture(), not canNeed)
	SetDesaturation(f.greedbutt:GetNormalTexture(), not canGreed)
	SetDesaturation(f.disenchantbutt:GetNormalTexture(), not canDisenchant)


	f.fsbind:SetText(bop and "BoP" or "BoE")
	f.fsbind:SetVertexColor(bop and 1 or .3, bop and .3 or 1, bop and .1 or .3)

	local color = ITEM_QUALITY_COLORS[quality]
	f.fsloot:SetVertexColor(color.r, color.g, color.b)
	f.fsloot:SetText(name)

	f:SetBackdropBorderColor(color.r, color.g, color.b, 1)
	f.buttonborder:SetBackdropBorderColor(color.r, color.g, color.b, 1)
	f.status:SetStatusBarColor(color.r, color.g, color.b, .7)

	f.status:SetMinMaxValues(0, time)
	f.status:SetValue(time)

	f:SetPoint("CENTER", WorldFrame, "CENTER")
	f:Show()
end


local function ParseRollChoice(msg)
	for i,v in pairs(ns.rollpairs) do
		local _, _, playername, itemname = string.find(msg, i)
		if playername and itemname and playername ~= "Everyone" then return playername, itemname, v end
	end
end


local in_soviet_russia = (GetLocale() == "ruRU")
local function CHAT_MSG_LOOT(msg)
	local playername, itemname, rolltype = ParseRollChoice(msg)
	if playername and itemname and rolltype then
		if in_soviet_russia and rolltype ~= "pass" then itemname, playername = playername, itemname end
		for _,f in ipairs(frames) do
			if f.rollid and f.button.link == itemname and not f.rolls[playername] then
				f.rolls[playername] = rolltype
				f[rolltype]:SetText(tonumber(f[rolltype]:GetText()) + 1)
				return
			end
		end
	end
end


anchor:RegisterEvent("ADDON_LOADED")
anchor:SetScript("OnEvent", function(frame, event, addon)
	if addon ~= "SYRoll" then return end

	anchor:UnregisterEvent("ADDON_LOADED")
	anchor:RegisterEvent("START_LOOT_ROLL")
	anchor:RegisterEvent("CHAT_MSG_LOOT")
	UIParent:UnregisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

	anchor:SetScript("OnEvent", function(frame, event, ...) if event == "CHAT_MSG_LOOT" then return CHAT_MSG_LOOT(...) else return START_LOOT_ROLL(...) end end)


	if not SYRollDB then SYRollDB = {} end
	anchor.db = SYRollDB
	anchor:SetPoint("CENTER", UIParent, "CENTER" , 0 ,300)---("CENTER", UIParent, anchor.db.x and "BOTTOMLEFT" or "BOTTOM", anchor.db.x or 0, anchor.db.y or buttonsize1)
end)


SlashCmdList["SYROLL"] = function() if anchor:IsVisible() then anchor:Hide() else anchor:Show() end end
SLASH_SYROLL1 = "/syroll"


SlashCmdList["LFrames"] = function(msg) 
	local f = GetFrame()
	local texture = select(10, GetItemInfo(32837))
	f.button:SetNormalTexture(texture)
	f.button:GetNormalTexture():SetTexCoord(.1, .9, .1, .9)
	f.fsloot:SetVertexColor(ITEM_QUALITY_COLORS[5].r, ITEM_QUALITY_COLORS[5].g, ITEM_QUALITY_COLORS[5].b)
	f.fsloot:SetText(GetItemInfo(32837))
	f.status:SetMinMaxValues(0, 100)
	f.status:SetValue(70)
	f.status:SetStatusBarColor(ITEM_QUALITY_COLORS[5].r, ITEM_QUALITY_COLORS[5].g, ITEM_QUALITY_COLORS[5].b)
	f:Show()
end
SLASH_LFrames1 = "/lframes"