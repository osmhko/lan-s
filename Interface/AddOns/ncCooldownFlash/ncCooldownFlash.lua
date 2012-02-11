local lib = LibStub("LibCooldown")
if not lib then error("ncCooldownFlash requires LibCooldown") return end

local filter = {
	["pet"] = "all",
	["item"] = {
		[6948] = true, -- hearthstone
	},
	["spell"] = {
	},
}

local flash = CreateFrame("Frame", nil, UIParent)
flash.icon = flash:CreateTexture(nil, "OVERLAY")
flash:SetScript("OnEvent", function()
	local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/GetCVar("uiScale")
	local function scale(x) return mult*math.floor(x+.5) end
	flash:SetPoint("CENTER", UIParent)
	flash:SetSize(scale(70),scale(70))
	flash:SetBackdrop({
	  --bgFile = [[Interface\AddOns\ncCooldownFlash\solid]], 
	  --edgeFile = [[Interface\AddOns\ncCooldownFlash\solid]], 
	  --tile = false, tileSize = 2, edgeSize = mult, 
	  --insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
		bgFile = "Interface\\Buttons\\WHITE8x8", 
		edgeFile = "Interface\\AddOns\\Media\\glow", 
		tile = false, tileSize = 4, edgeSize = 4, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 }

	})
	flash:SetBackdropColor(0, 0, 0,.8)
	flash:SetBackdropBorderColor(0, 0, 0)--(.6,.6,.6)
	flash.icon:SetPoint("TOPLEFT", scale(4), scale(-4))
	flash.icon:SetPoint("BOTTOMRIGHT", scale(-4), scale(4))
	flash.icon:SetTexCoord(.08, .92, .08, .92)
	flash:Hide()
	flash:SetScript("OnUpdate", function(self, e)
		flash.e = flash.e + e
		if flash.e > .75 then
			flash:Hide()
		elseif flash.e < .25 then
			flash:SetAlpha(flash.e*4)
		elseif flash.e > .5 then
			flash:SetAlpha(1-(flash.e%.5)*4)
		end
	end)
	flash:UnregisterEvent("PLAYER_ENTERING_WORLD")
	flash:SetScript("OnEvent", nil)
end)
flash:RegisterEvent("PLAYER_ENTERING_WORLD")

lib:RegisterCallback("stop", function(id, class)
	if filter[class]=="all" or filter[class][id] then return end
	flash.icon:SetTexture(class=="item" and GetItemIcon(id) or select(3, GetSpellInfo(id)))
	flash.e = 0
	flash:Show()
end)
