local _, ns = ...

local MyAddon = CreateFrame("Frame")
local imsg = CreateFrame("Frame", "CombatAlert")
imsg:SetSize(418, 72)
imsg:SetPoint("TOP", 0, -290)
imsg:Hide()
imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
--imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.bg:SetPoint('BOTTOM')
imsg.bg:SetSize(200, 50)
imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
imsg.bg:SetVertexColor(1, 1, 1, 0.6)

-- imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
-- imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
-- imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
-- imsg.lineTop:SetPoint("TOP")
-- imsg.lineTop:SetSize(418, 7)
-- imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

-- imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
-- imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
 --imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
-- imsg.lineBottom:SetPoint("BOTTOM")
-- imsg.lineBottom:SetSize(418, 7)
-- imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
imsg.text:SetPoint("BOTTOM", 0, 12)
imsg.text:SetTextColor(1, 0.82, 0)
--imsg.text:SetTextColor(0, 1, 1)
imsg.text:SetJustifyH("CENTER")

 local flag = 0
ExecuteThreshold =  ns.setting.ExecuteThreshold
local function ShowAlert(texts)
	CombatAlert.text:SetText(texts[math.random(1,table.getn(texts))])
	CombatAlert:Show()
end

-- MyAddon:RegisterEvent("PLAYER_REGEN_ENABLED")
-- MyAddon:RegisterEvent("PLAYER_REGEN_DISABLED")
if ns.setting.EnableExecute then
	MyAddon:RegisterEvent("UNIT_HEALTH")
	MyAddon:RegisterEvent("PLAYER_TARGET_CHANGED")
end
if ns.setting.AutoThreshold then
	MyAddon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	MyAddon:RegisterEvent("PLAYER_ENTERING_WORLD")
end

MyAddon:SetScript("OnEvent", function(self, event)
	-- if event == "PLAYER_REGEN_DISABLED" then
		-- ShowAlert(ns.texts.EnterCombat)
		-- flag = 0
	-- elseif event == "PLAYER_REGEN_ENABLED" then
		-- ShowAlert(ns.texts.LeaveCombat)
		-- flag = 0
	if event == "PLAYER_TARGET_CHANGED" then
		flag = 0
	--elseif event == "UNIT_HEALTH" then
	elseif event == "UNIT_HEALTH" and ExecuteThreshold then
		if (UnitName("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") and ( UnitHealth("target")/UnitHealthMax("target") < ExecuteThreshold ) and flag == 0 ) then
			if ((ns.setting.OnlyShowBoss and UnitLevel("target")==-1) or ( not ns.setting.OnlyShowBoss)) then 
				ShowAlert(ns.texts.ExecutePhase)
			end
			flag = 1
		end
	elseif event == "PLAYER_ENTERING_WORLD" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
		ExecuteThreshold = ns.class[select(2, UnitClass("player"))][GetPrimaryTalentTree()]
	end	
end)
local timer = 0
imsg:SetScript("OnShow", function(self)
	timer = 0
	self:SetScript("OnUpdate", function(self, elasped)
		timer = timer + elasped
		if (timer<0.5) then self:SetAlpha(timer*2) end
		if (timer>1 and timer<1.5) then self:SetAlpha(1-(timer-1)*2) end
		if (timer>=1.5 ) then self:Hide() end
	end)
end)