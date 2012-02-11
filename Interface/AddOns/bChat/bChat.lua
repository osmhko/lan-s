-----------------------------------------------
--Config
-----------------------------------------------
-- Font Shadow
shadowoffset = {x = 1, y = -1}
-- Hide Black Combat Log Bar
hidecombat = true
-- Justify Combat Log to the Right, 0/1 = off/on
combatlogright = 0
-----------------------------------------------
--Config End
-----------------------------------------------
-- for i = 1, NUM_CHAT_WINDOWS do
  -- local cf = _G['ChatFrame'..i]
  -- if cf then 
    -- cf:SetFont(NAMEPLATE_FONT, 11, "THINOUTLINE") 
    -- cf:SetFrameStrata("LOW")
    -- cf:SetFrameLevel(2)
  -- end
  -- local tab = _G['ChatFrame'..i..'Tab']
  -- if tab then
    -- tab:GetFontString():SetFont(NAMEPLATE_FONT, 11, "THINOUTLINE")
    ----fix for color and alpha of undocked frames
    -- tab:GetFontString():SetTextColor(1,0.7,0)
    -- tab:SetAlpha(1)
  -- end
-- end
for i = 1, 7 do
   local chat = _G["ChatFrame"..i]
   local font, size = chat:GetFont()
   chat:SetFont(font, size, "OUTLINE")
   chat:SetShadowOffset(0, 0)
   chat:SetShadowColor(0, 0, 0, 0)
end


local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_ENTERING_WORLD")
Event:SetScript("OnEvent", function(self)
	Event:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if not UnitAffectingCombat("player") then
		FCF_SetLocked(ChatFrame1, nil)
		FCF_SetChatWindowFontSize(self, ChatFrame1, 13) 
		ChatFrame1:ClearAllPoints()
		ChatFrame1:SetPoint("BOTTOMLEFT", 15, 33)
		ChatFrame1:SetWidth(300)
		ChatFrame1:SetHeight(130)
		ChatFrame1:SetUserPlaced(true)
		for i = 1,10 do FCF_SetWindowAlpha(_G["ChatFrame"..i], 0) end
		FCF_SavePositionAndDimensions(ChatFrame1)
		FCF_SetLocked(ChatFrame1, 1)
	end
end)



--local AutoApply = true											-- /setchat upon UI loading                    --Setchat parameters. Those parameters will apply to ChatFrame1 when you use /setchat
-- local def_position = {"BOTTOMLEFT",UIParent,"BOTTOMLEFT",10,30} -- Chat Frame position
-- local chat_height = 145
-- local chat_width = 350
-- local fontsize = 14
--                          other variables
-- local eb_point = {"BOTTOM", -200, 180}		-- Editbox position
-- local eb_width = 300					 	            -- Editbox width
-- local tscol = "64C2F5"						            -- Timestamp coloring
-- local TimeStampsCopy = true					    -- Enables special time stamps in chat allowing you to copy the specific line from your chat window by clicking the stamp
-- local LinkHover = {}; LinkHover.show = {	    -- enable (true) or disable (false) LinkHover functionality for different things in chat
	-- ["achievement"] = true,
	-- ["enchant"]     = true,
	-- ["glyph"]       = true,
	-- ["item"]        = true,
	-- ["quest"]       = true,
	-- ["spell"]       = true,
	-- ["talent"]      = true,
	-- ["unit"]        = true,}
	

------------------------------------------------1像素边框
for i = 1, NUM_CHAT_WINDOWS do
	local parent
	parent = _G["ChatFrame"..i]	
	local chatframe = CreateFrame("Frame",nil,parent)
	chatframe:SetPoint("TOPLEFT",parent,"TOPLEFT",-5,8)
	chatframe:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",5,-8)
	chatframe:SetFrameLevel("0")
	chatframe:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8x8", 
		edgeFile = "Interface\\AddOns\\Media\\glow", 
		tile = false, tileSize = 4, edgeSize = 4, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	chatframe:SetBackdropColor(0,0,0,0.5)
	chatframe:SetBackdropBorderColor(0,0,0,1)
end

	--  聊天复制
local _AddMessage = ChatFrame1.AddMessage
local _SetItemRef = SetItemRef
local blacklist = {
	[ChatFrame2] = true,
}

local ts = '|cff68ccef|HyCopy|h%s|h|r %s'
local AddMessage = function(self, text, ...)
	if(type(text) == 'string') then
        if showtime then
            text = format(ts, date'%H:%M', text)  --text = format(ts, date'%H:%M:%S', text)
        else
	        text = format(ts, '·', text)
       end
end

	return _AddMessage(self, text, ...)
end

for i=1, NUM_CHAT_WINDOWS do
	local cf = _G['ChatFrame'..i]
	if(not blacklist[cf]) then
		cf.AddMessage = AddMessage
	end
end

local MouseIsOver = function(frame)
	local s = frame:GetParent():GetEffectiveScale()
	local x, y = GetCursorPosition()
	x = x / s
	y = y / s

	local left = frame:GetLeft()
	local right = frame:GetRight()
	local top = frame:GetTop()
	local bottom = frame:GetBottom()

	if(not left) then
		return
	end

	if((x > left and x < right) and (y > bottom and y < top)) then
		return 1
	else
		return
	end
end

local borderManipulation = function(...)
	for l = 1, select('#', ...) do
		local obj = select(l, ...)
		if(obj:GetObjectType() == 'FontString' and MouseIsOver(obj)) then
			return obj:GetText()
		end
	end
end

local eb = ChatFrame1EditBox
SetItemRef = function(link, text, button, ...)
	if(link:sub(1, 5) ~= 'yCopy') then return _SetItemRef(link, text, button, ...) end

	local text = borderManipulation(SELECTED_CHAT_FRAME:GetRegions())
	if(text) then
		text = text:gsub('|c%x%x%x%x%x%x%x%x(.-)|r', '%1')
		text = text:gsub('|H.-|h(.-)|h', '%1')

		eb:Insert(text)
		eb:Show()
		eb:HighlightText()
		eb:SetFocus()
	end
end


	
-- 输入框
-- for i = 1, NUM_CHAT_WINDOWS do
	-- _G["ChatFrame"..i.."EditBox"]:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
    -- _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
	
	-- _G["ChatFrame"..i.."EditBox"]:SetPoint("TOPLEFT", _G["ChatFrame"..i], "BOTTOMLEFT", -10, -5)
	-- _G["ChatFrame"..i.."EditBox"]:SetPoint("TOPRIGHT", _G["ChatFrame"..i], "BOTTOMRIGHT", 10, -5)
	-- _G["ChatFrame"..i.."EditBox"]:SetPoint("BOTTOMLEFT", _G["ChatFrame"..i], "BOTTOMLEFT", -10, -30)
	-- _G["ChatFrame"..i.."EditBox"]:SetPoint("BOTTOMRIGHT", _G["ChatFrame"..i], "BOTTOMRIGHT", 10, -30)
	
	-- _G["ChatFrame"..i.."EditBox"]:SetScale(0.9)
	
	-- local tex = ({ _G["ChatFrame"..i.."EditBox"]:GetRegions() })
	-- for t = 6,11 do
		-- tex[t]:SetAlpha(0)
	-- end
	
	-- _G["ChatFrame"..i.."EditBoxLanguage"]:ClearAllPoints()
-- end


CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
ChatTypeInfo.WHISPER.sticky = 0
ChatTypeInfo['WHISPER'].sticky = 0				--悄悄話
ChatTypeInfo.BN_WHISPER.sticky = 0		    --实名密语
ChatTypeInfo.OFFICER.sticky = 1
ChatTypeInfo.CHANNEL.sticky = 1

ChatFrameMenuButton.Show = ChatFrameMenuButton.Hide 
ChatFrameMenuButton:Hide() 
FriendsMicroButton.Show = FriendsMicroButton.Hide 
FriendsMicroButton:Hide()
BNToastFrame:SetClampedToScreen(true)

CHAT_FRAME_FADE_OUT_TIME = 1
CHAT_TAB_HIDE_DELAY = 1
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0

if hidecombat==true then
    local EventFrame = CreateFrame("Frame");
    EventFrame:RegisterEvent("ADDON_LOADED");
    local function EventHandler(self, event, ...)
        if ... == "Blizzard_CombatLog" then
            local topbar = _G["CombatLogQuickButtonFrame_Custom"];
            if not topbar then return end
            topbar:Hide();
            topbar:HookScript("OnShow", function(self) topbar:Hide(); end);
            topbar:SetHeight(0);
        end
    end
    EventFrame:SetScript("OnEvent", EventHandler);
end

local gsub = _G.string.gsub
local newAddMsg = {}
CHAT_FLAG_GM = "GM "
CHAT_BN_WHISPER_INFORM_GET = "T: %s "
CHAT_BN_WHISPER_GET = "F: %s "
CHAT_RAID_WARNING_GET = "%s "

local function AddMessage(frame, text, ...)
    text = gsub(text, "%[(%d0?)%. .-%]", "%1")
    text = gsub(text, "^|Hchannel:[^%|]+|h%[[^%]]+%]|h ", "")
	text = gsub(text, "|Hplayer:([^%|]+)|h%[([^%]]+)%]|h", "|Hplayer:%1|h%2|h")
    text = gsub(text, "<Away>", "")
	text = gsub(text, "<Busy>", "")
    text = gsub(text, "|Hplayer:([^%|]+)|h(.+)|h says:", "|Hplayer:%1|h%2|h:")
	text = gsub(text, "|Hplayer:([^%|]+)|h(.+)|h yells:", "|Hplayer:%1|h%2|h:")
	text = gsub(text, "|Hplayer:([^%|]+)|h(.+)|h whispers:", "F |Hplayer:%1|h%2|h:")
	text = gsub(text, "^To ", "T ")
    text = gsub(text, "Guild Message of the Day:", "GMotD -")
    text = gsub(text, '([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r')
	return newAddMsg[frame:GetName()](frame, text, ...)
end

function string.color(text, color)
    return "|cff"..color..text.."|r"
end
function string.link(text, type, value, color)
    return "|H"..type..":"..tostring(value).."|h"..tostring(text):color(color or "ffffff").."|h"
end
local function highlighturl(before,url,after)
    foundurl = true
    return " "..string.link(""..url.."", "url", url, "DDDDDD").." "
end
local function searchforurl(frame, text, ...)
    foundurl = false
    if string.find(text, "%pTInterface%p+") then foundurl = true end
    if not foundurl then text = string.gsub(text, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)(%s?)", highlighturl) end
    if not foundurl then text = string.gsub(text, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)(%s?)", highlighturl) end
    if not foundurl then text = string.gsub(text, "(%s?)([%w_-]+%.?[%w_-]+%.[%w_-]+:%d%d%d?%d?%d?)(%s?)", highlighturl) end
    if not foundurl then text = string.gsub(text, "(%s?)(%a+://[%w_/%.%?%%=~&-'%-]+)(%s?)", highlighturl) end
    if not foundurl then text = string.gsub(text, "(%s?)(www%.[%w_/%.%?%%=~&-'%-]+)(%s?)", highlighturl) end
    if not foundurl then text = string.gsub(text, "(%s?)([_%w-%.~-]+@[_%w-]+%.[_%w-%.]+)(%s?)", highlighturl) end
    frame.am(frame,text,...)
end--]]

local tabs = {"Left", "Middle", "Right", "SelectedLeft", "SelectedMiddle",
    "SelectedRight", "Glow", "HighlightLeft", "HighlightMiddle", 
    "HighlightRight"}

for i = 1, NUM_CHAT_WINDOWS do _G["ChatFrame"..i.."EditBoxLanguage"]:Hide() _G["ChatFrame"..i.."EditBoxLanguage"].Show = function() return end end


for i = 1, NUM_CHAT_WINDOWS do
    local cf = 'ChatFrame'..i
    local tex = ({_G[cf..'EditBox']:GetRegions()})
    
    _G[cf..'ButtonFrame'].Show = _G[cf..'ButtonFrame'].Hide 
    _G[cf..'ButtonFrame']:Hide()
 
    _G[cf..'EditBox']:SetAltArrowKeyMode(false)
    _G[cf..'EditBox']:ClearAllPoints()
    _G[cf..'EditBox']:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', -4, 10)
    _G[cf..'EditBox']:SetPoint('TOPRIGHT', _G.ChatFrame1, 'TOPRIGHT', 4, 30)
    -- _G[cf..'EditBox']:SetPoint('TOPLEFT', ChatFrame1, 'BOTTOMLEFT', -10, -5)
    -- _G[cf..'EditBox']:SetPoint('BOTTOMRIGHT', _G.ChatFrame1, 'BOTTOMRIGHT', -10, -30)
    _G[cf..'EditBox']:SetShadowOffset(0, 0)
    _G[cf..'EditBox']:SetBackdrop({
	    bgFile = 'Interface\\Buttons\\WHITE8x8', 
	    edgeFile = 'Interface\\Addons\\media\\glow', 
		tile = false, tileSize = 3,edgeSize = 3,
	    insets = { left = 3, right = 3, top = 3, bottom = 3}
		})
    _G[cf..'EditBox']:SetBackdropColor(0,0,0,0.5)
    _G[cf..'EditBox']:SetBackdropBorderColor(0,0,0,1)
    _G[cf..'EditBox']:HookScript("OnEditFocusGained", function(self) self:Show() end)
	_G[cf..'EditBox']:HookScript("OnEditFocusLost", function(self) self:Hide() end)
    _G[cf..'EditBoxHeader']:SetShadowOffset(0, 0)
    
	_G["ChatFrame"..i.."Tab"]:HookScript("OnClick", function() _G["ChatFrame"..i.."EditBox"]:Hide() end)
    tex[6]:SetAlpha(0) tex[7]:SetAlpha(0) tex[8]:SetAlpha(0) tex[9]:SetAlpha(0) tex[10]:SetAlpha(0) tex[11]:SetAlpha(0)
    _G[cf]:SetMinResize(0,0)
	_G[cf]:SetMaxResize(0,0)
    _G[cf]:SetFading(true)	
	_G[cf]:SetClampRectInsets(0,0,0,0)
    _G[cf]:SetShadowOffset(shadowoffset.x, shadowoffset.y)
    _G[cf..'ResizeButton']:SetPoint("BOTTOMRIGHT", cf, "BOTTOMRIGHT", 9,-5)
    _G[cf..'ResizeButton']:SetScale(.4)
    _G[cf..'ResizeButton']:SetAlpha(0.5)
    
    for g = 1, #CHAT_FRAME_TEXTURES do
        _G["ChatFrame"..i..CHAT_FRAME_TEXTURES[g]]:SetTexture(nil)
    end
    for index, value in pairs(tabs) do
        local texture = _G['ChatFrame'..i..'Tab'..value]
        texture:SetTexture(nil)
    end
    if i ~= 2 then
		local f = _G[format("%s%d", "ChatFrame", i)]
		newAddMsg[format("%s%d", "ChatFrame", i)] = f.AddMessage
		f.AddMessage = AddMessage
	end
    if combatlogright == 1 then
        if i == 2 then
            _G[cf]:SetJustifyH("Right")
        end
    end
end

local AltInvite = SetItemRef
SetItemRef = function(link, text, button)
    local linkType = string.sub(link, 1, 6)
    if IsAltKeyDown() and linkType == "player" then
        local name = string.match(link, "player:([^:]+)")
        InviteUnit(name)
        return nil
    end
    return AltInvite(link,text,button)
end

FloatingChatFrame_OnMouseScroll = function(self, dir)
    if(dir > 0) then
        if(IsShiftKeyDown()) then
            self:ScrollToTop() else self:ScrollUp() end
    else if(IsShiftKeyDown()) then 
        self:ScrollToBottom() else self:ScrollDown() end
    end
end

local orig = ChatFrame_OnHyperlinkShow
function ChatFrame_OnHyperlinkShow(frame, link, text, button)
    local type, value = link:match("(%a+):(.+)")
    if ( type == "url" ) then
        local eb = _G[frame:GetName()..'EditBox']
        if eb then
            eb:SetText(value)
            eb:SetFocus()
            eb:HighlightText()
        end
    else
        orig(self, link, text, button)
    end
end--]]
