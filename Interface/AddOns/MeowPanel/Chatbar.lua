local _, SR = ...
local cfg = SR.ChatConfig

--local Channel = {"/s ","/y ","/p ","/g ","/raid ","/1 ","/2 "}
local Color = {
	{255/255, 255/255, 255/255, 0.8},
	{255/255,  64/255,  64/255, 0.8},
	{170/255, 170/255, 255/255, 0.8},
	{ 64/255, 255/255,  64/255, 0.8},
	{255/255, 127/255,   0/255, 0.8},
	{210/255, 180/255, 140/255, 0.8},
	{160/255, 120/255,  90/255, 0.8},
	{255/255, 255/255,   0/255, 0.8},
}

local Chatbar = CreateFrame("Frame","Chatbar",UIParent)
Chatbar:SetWidth(160)
Chatbar:SetHeight(20)
Chatbar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 7, 1)
Chatbar:SetScale(0.9)

-- for i=1,7 do
	-- local frame = CreateFrame("Button", "ChatBarButton"..i , Chatbar)
	-- frame:SetWidth(20)
	-- frame:SetHeight(Chatbar:GetHeight())
	-- if i == 1 then
		-- frame:SetPoint("LEFT",Chatbar,"LEFT",0,0)
	-- else
		-- frame:SetPoint("LEFT","ChatBarButton"..i-1,"RIGHT",0,0)
	-- end
	-- frame:SetBackdrop( { 
		-- bgFile = cfg.Statusbar,
		-- insets = { left = 3, right = 3, top = 3, bottom = 3 },
		-- edgeFile = cfg.edgeFile, edgeSize = 4, 
	-- }) 
	-- frame:SetBackdropColor(unpack(Color[i]))
	-- frame:SetBackdropBorderColor(0,0,0,1)	
	-- frame:RegisterForClicks("AnyUp")
	-- frame:SetScript("OnClick", function() 
		-- ChatFrame_OpenChat(Channel[i], chatFrame)
	-- end)
-- end

-- Roll Ni Mei --
local roll = CreateFrame("Button",nil, Chatbar, "SecureActionButtonTemplate")
--roll:SetAttribute("*type*", "macro")
--roll:SetAttribute("macrotext", "/roll")
roll:SetWidth(40)
roll:SetHeight(Chatbar:GetHeight())
roll:SetPoint("LEFT",Chatbar,"LEFT",0,0)
roll:SetBackdrop( { 
	bgFile = "Interface\\Addons\\Media\\Statusbar",
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
	edgeFile = "Interface\\Addons\\Media\\glowTex", edgeSize = 4, 
})
roll:SetBackdropColor(unpack(Color[8]))
roll:SetBackdropBorderColor(0,0,0,1)	
roll:RegisterForClicks("AnyUp")
roll:RegisterEvent("CHAT_MSG_CHANNEL")
roll:SetScript("OnClick",function(self)
	local name = "大脚世界频道"
	local channels = {GetChannelList()}
	isInCustomChannel = false
	for i =1, #channels do
		if channels[i] == name then
			isInCustomChannel = true
		end
	end
	if isInCustomChannel then
		LeaveChannelByName(name)
		self:SetBackdropColor(1,.1,.1)
	else
		JoinChannelByName(name)			
		if ChatFrame4Tab:IsShown() then
			ChatFrame_AddChannel(ChatFrame4,name)
		else
			ChatFrame_AddChannel(ChatFrame1,name)
		end
		self:SetBackdropColor(.1,1,.1)
	end
end)
roll:SetScript("OnEvent", function(self)
	--self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	local channels = {GetChannelList()}
	local inchannel = false
	local name = "大脚世界频道"
	for i =1, #channels do
		if channels[i] == name then
			inchannel = true
		end
	end
	if inchannel then 
		self:SetBackdropColor(.1,1,.1)
	else
		self:SetBackdropColor(1,.1,.1)
	end
end)