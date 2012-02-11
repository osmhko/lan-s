if not IsAddOnLoaded("ElvUI") then return end
local E, C, L, DB = unpack(ElvUI)

local ElvUISkin = CreateFrame("Frame")
ElvUISkin:RegisterEvent("MAIL_SHOW")

ElvUISkin:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("MAIL_SHOW")
	E.SkinButton(PostalSelectOpenButton)
	E.SkinButton(PostalSelectReturnButton)
	E.SkinButton(PostalOpenAllButton)
end)