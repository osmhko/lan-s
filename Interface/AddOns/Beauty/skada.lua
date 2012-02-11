local B, C = unpack(select(2, ...))

if not IsAddOnLoaded("Skada") then return end

local Skada = Skada
local barSpacing = B.Scale(1)
local bars = 8

local barmod = Skada.displays["bar"]

Skada.windowdefaults = {
	barcolor = {r = 0, g = 0.5, b = 0.85, a=0.4},
	baraltcolor = {r = 1, g = 1, b = 1, a = 0},
}

-- Used to strip unecessary options from the in-game config
local function StripOptions(options)
	options.baroptions.args.barspacing = nil
	options.titleoptions.args.texture = nil
	options.titleoptions.args.bordertexture = nil
	options.titleoptions.args.thickness = nil
	options.titleoptions.args.margin = nil
	options.titleoptions.args.color = nil
	options.windowoptions = nil
	options.baroptions.args.barfont = nil
	options.titleoptions.args.font = nil
end

local barmod = Skada.displays["bar"]
barmod.AddDisplayOptions_ = barmod.AddDisplayOptions
barmod.AddDisplayOptions = function(self, win, options)
	self:AddDisplayOptions_(win, options)
	StripOptions(options)
end

for k, options in pairs(Skada.options.args.windows.args) do
	if options.type == "group" then
		StripOptions(options.args)
	end
end

barmod.ApplySettings_ = barmod.ApplySettings
barmod.ApplySettings = function(self, win)
	barmod.ApplySettings_(self, win)

	local skada = win.bargroup

	if win.db.enabletitle then
		skada.button:SetBackdrop(nil)
	end

	skada:SetTexture(C.normal)
	skada:SetSpacing(barSpacing)
	skada:SetFrameLevel(5)
	
	local titlefont = CreateFont("TitleFont"..win.db.name)
	titlefont:SetFont(C.font, C.fontsize, "OUTLINE")
	win.bargroup.button:SetNormalFontObject(titlefont)

	local color = win.db.title.color
	win.bargroup.button:SetBackdropColor(unpack(C.bordercolor))

	skada:SetBackdrop(nil)
	if not skada.shadow then
		skada:CreateShadow("Background")
	end
	skada.shadow:ClearAllPoints()
	if win.db.enabletitle then
		skada.shadow:Point('TOPLEFT', win.bargroup.button, 'TOPLEFT', -5, 5)
	else
		skada.shadow:Point('TOPLEFT', win.bargroup, 'TOPLEFT', -5, 5)
	end
	skada.shadow:Point('BOTTOMRIGHT', win.bargroup, 'BOTTOMRIGHT', 5, -5)
	
	win.bargroup.button:SetFrameStrata("MEDIUM")
	win.bargroup.button:SetFrameLevel(5)	
	win.bargroup:SetFrameStrata("MEDIUM")
end

hooksecurefunc(Skada, "UpdateDisplay", function(self)
	for _,window in ipairs(self:GetWindows()) do
		for i,v in pairs(window.bargroup:GetBars()) do
			if not v.BarStyled then
				v.label:ClearAllPoints()
				v.label.ClearAllPoints = B.dummy
				v.label:SetPoint("LEFT", v, "LEFT", 2, 0)
				v.label.SetPoint = B.dummy
				v.timerLabel:ClearAllPoints()
				v.timerLabel.ClearAllPoints = B.dummy
				v.timerLabel:SetPoint("RIGHT", v, "RIGHT", -2, 0)
				v.timerLabel.SetPoint = B.dummy
				v.label:SetFont(C.font, C.fontsize, "OUTLINE")
				v.label.SetFont = B.dummy
				v.timerLabel:SetFont(C.font, C.fontsize, "OUTLINE")
				v.timerLabel.SetFont = B.dummy
				v.label:SetShadowOffset(0, 0)
				v.label.SetShadowOffset = B.dummy
				v.timerLabel:SetShadowOffset(0, 0)
				v.timerLabel.SetShadowOffset = B.dummy
				v.BarStyled = true
			end
		end
	end
end)

if not C.skadalock then return end

local function EmbedWindow(window, width, barheight, height, point, relativeFrame, relativePoint, ofsx, ofsy)
	window.db.barwidth = width
	window.db.barheight = barheight
	if window.db.enabletitle then 
		height = height - barheight
	end
	window.db.background.height = height
	window.db.spark = false
	window.db.barslocked = true
	window.bargroup:ClearAllPoints()
	window.bargroup:SetPoint(point, relativeFrame, relativePoint, ofsx, ofsy)
	
	barmod.ApplySettings(barmod, window)
end

local windows = {}
function EmbedSkada()
	if #windows == 1 then
		EmbedWindow(windows[1], 270, 140/bars - barSpacing, 140, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -15, 30)
	elseif #windows == 2 then
		EmbedWindow(windows[1], 270, 140/bars - barSpacing, 140, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -15, 30)
		EmbedWindow(windows[2], 270, 140/bars - barSpacing, 140, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -250, 0)
	end
end

-- Update pre-existing displays
for _, window in ipairs(Skada:GetWindows()) do
	window:UpdateDisplay()
end

Skada.CreateWindow_ = Skada.CreateWindow
function Skada:CreateWindow(name, db)
	Skada:CreateWindow_(name, db)
	
	windows = {}
	for _, window in ipairs(Skada:GetWindows()) do
		tinsert(windows, window)
	end	
	
	EmbedSkada()
end

Skada.DeleteWindow_ = Skada.DeleteWindow
function Skada:DeleteWindow(name)
	Skada:DeleteWindow_(name)
	
	windows = {}
	for _, window in ipairs(Skada:GetWindows()) do
		tinsert(windows, window)
	end	
	
	EmbedSkada()
end

local Skada_Skin = CreateFrame("Frame")
Skada_Skin:RegisterEvent("PLAYER_ENTERING_WORLD")
Skada_Skin:SetScript("OnEvent", function(self)
	self:UnregisterAllEvents()
	self = nil
	
	EmbedSkada()
end)