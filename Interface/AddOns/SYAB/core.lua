if IsAddOnLoaded("Beauty") then return end

local addon, func = ...
func[1] = {}
func[2] = {}
Beauty = func
local B, C = unpack(select(2, ...))

C.uiscale = 0.8
C.dbmlock = true
C.skadalock =true

C.normal = "Interface\\Addons\\Beauty\\media\\statusbar"
C.glow = "Interface\\Addons\\Beauty\\media\\glowtex"
C.blank = "Interface\\Addons\\Beauty\\media\\blank"
C.font = "Fonts\\ZYKai_C.ttf"
C.fontsize = 14
C.fontflag = "OUTLINE"
C.bordercolor = {0,0,0,1}
C.backdropcolor = {.05,.05,.05,.9}

B.dummy= function() return end
_, B.myclass = UnitClass("player")
B.level = UnitLevel("player")

local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C.uiscale
local function scale(x)
	return (mult*math.floor(x/mult+.5))
end
B.mult = mult
B.Scale = scale

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = scale(arg1) end
	if type(arg2)=="number" then arg2 = scale(arg2) end
	if type(arg3)=="number" then arg3 = scale(arg3) end
	if type(arg4)=="number" then arg4 = scale(arg4) end
	if type(arg5)=="number" then arg5 = scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function CreateBorder(f, r, g, b, a)
	f:SetBackdrop({
		edgeFile = C.blank, 
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	})
	f:SetBackdropBorderColor(0,0,0,1)
end

local function CreateShadow(f, t, offset, thickness, texture)
	if f.shadow then return end
	
	local borderr, borderg, borderb, bordera = 0,0,0,1 
	local backdropr, backdropg, backdropb, backdropa = .05,.05,.05, .9
	
	if t == "Background" then
		backdropa = 0.6
	else
		backdropa = 0
	end
	
	local border = CreateFrame("Frame", nil, f)
	border:SetFrameLevel(1)
	Point(border,"TOPLEFT", -1, 1)
	Point(border,"TOPRIGHT", 1, 1)
	Point(border,"BOTTOMRIGHT", 1, -1)
	Point(border,"BOTTOMLEFT", -1, -1)
	CreateBorder(border)
	f.border = border
	
	local shadow = CreateFrame("Frame", nil, border)
	shadow:SetFrameLevel(0)
	Point(shadow,"TOPLEFT", -3, 3)
	Point(shadow,"TOPRIGHT", 3, 3)
	Point(shadow,"BOTTOMRIGHT", 3, -3)
	Point(shadow,"BOTTOMLEFT", -3, -3)
	shadow:SetBackdrop( { 
		edgeFile = C.glow,
		bgFile = C.blank,
		edgeSize = scale(4),
		insets = {left = scale(4), right = scale(4), top = scale(4), bottom = scale(4)},
	})
	shadow:SetBackdropColor( backdropr, backdropg, backdropb, backdropa )
	shadow:SetBackdropBorderColor( borderr, borderg, borderb, bordera )
	f.shadow = shadow
end

local function Kill(object)
	if object.IsProtected then 
		if object:IsProtected() then
			error("Attempted to kill a protected object: <"..object:GetName()..">")
		end
	end
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = function() return end
	object:Hide()
end

local function Size(frame, width, height)
	frame:SetSize(scale(width), scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(scale(width))
end

local function Height(frame, height)
	frame:SetHeight(scale(height))
end

local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	local sh = scale(h)
	local sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, scale(x), scale(y))
	if t ~= "Transparent" then
		CreateShadow(f,"Background")
	else
		CreateShadow(f,t)
	end
end

local function StyleButton(button, setallpoints)
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture(nil, "OVERLAY")
		hover:SetTexture(1, 1, 1, 0.3)
		if setallpoints then
			hover:SetAllPoints()
		else
			hover:Point('TOPLEFT', 2, -2)
			hover:Point('BOTTOMRIGHT', -2, 2)
		end
		button.hover = hover
		button:SetHighlightTexture(hover)
	end
	
	if button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture(nil, "OVERLAY")
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		if setallpoints then
			pushed:SetAllPoints()
		else
			pushed:Point('TOPLEFT', 2, -2)
			pushed:Point('BOTTOMRIGHT', -2, 2)
		end
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end
	
	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture(nil, "OVERLAY")
		checked:SetTexture(23/255,132/255,209/255,0.5)
		if setallpoints then
			checked:SetAllPoints()
		else
			checked:Point('TOPLEFT', 2, -2)
			checked:Point('BOTTOMRIGHT', -2, 2)
		end
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	if button:GetName() and _G[button:GetName().."Cooldown"] then
		local cooldown = _G[button:GetName().."Cooldown"]
		cooldown:ClearAllPoints()
		if setallpoints then
			cooldown:SetAllPoints()
		else
			cooldown:Point('TOPLEFT', 2, -2)
			cooldown:Point('BOTTOMRIGHT', -2, 2)
		end
	end
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Size then mt.Size = Size end
	if not object.Point then mt.Point = Point end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreateShadow then mt.CreateShadow = CreateShadow end
	if not object.Kill then mt.Kill = Kill end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
end
local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())
object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end