--susnow
--素雪@风暴之眼

local addon,ns = ...

--init varirable
local sName = "魔法双翼"
local interval = 0.001
local minThreshold = 1.4
local maxThreshold = 1.45 
local L = {
	["enUS"] = function() return "Click!" end,
	["zhCN"] = function() return "按!" end,
	["zhTW"] = function() return "按!" end
}
local sTex = "Interface\\Icons\\misc_arrowdown"

--Custom func
local onUpdate = function(obj,elapsed,interval,expires,minV,maxV)
	obj.nextUpdate = obj.nextUpdate + elapsed
	if obj.nextUpdate > interval then
		if (expires - GetTime() > minV ) and (expires - GetTime() < maxV) then
			obj.notice:SetText(L[GetLocale()]())
			obj.sIcon:SetAlpha(1)
		elseif expires - GetTime() <= 1 then
			obj.notice:SetText("")
			obj.sIcon:SetAlpha(0)
			obj:SetScript("OnUpdate",nil)
		end
	end
	obj.nextUpdate = 0
end

--objects
--frame
local Bullseye = CreateFrame("Frame")
Bullseye:SetSize(100,20)
Bullseye:SetPoint("CENTER",UIParent,0,150)

--text
local notice = Bullseye:CreateFontString(nil,"OVERLAY")
notice:SetFontObject(ChatFontNormal)
do
	local font,size,flag = notice:GetFont()
	notice:SetFont(font,16,"OUTLINE")
	notice:SetTextColor(1,1,0,1)
	notice:SetShadowOffset(2,-2)
end
notice:SetPoint("CENTER",Bullseye)
notice:SetText("")
Bullseye.notice = notice

--icon
local sIcon = Bullseye:CreateTexture(nil,"OVERLAY")
sIcon:SetSize(30,30)
sIcon:SetTexture(sTex)
sIcon:SetPoint("RIGHT",Bullseye,"LEFT")
sIcon:SetAlpha(0)
Bullseye.sIcon = sIcon

--handler
Bullseye.nextUpdate = 0
Bullseye:RegisterEvent("UNIT_AURA")
Bullseye:HookScript("OnEvent",function(self)
		local name,_,_,_,_,_, expires = UnitBuff("player",sName)		
		if name == sName  then 
			Bullseye:SetScript("OnUpdate",function(self,elapsed)
				onUpdate(self,elapsed,interval,expires,minThreshold,maxThreshold)
			end)
		end
end)

