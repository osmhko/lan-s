local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

  
local bar = CreateFrame("Frame","_UIActionBar5",UIParent, "SecureHandlerStateTemplate")
bar:SetHeight(C["actionbar"].buttonsize*12+C["actionbar"].buttonspacing*11)
bar:SetWidth(C["actionbar"].buttonsize)
bar:SetPoint("RIGHT", _UIActionBar4, "LEFT", -C["actionbar"].buttonspacing, 0)
bar:SetHitRectInsets(-C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset)

bar:SetScale(C["actionbar"].barscale)



MultiBarLeft:SetParent(bar)
  
  for i=1, 12 do
    local button = _G["MultiBarLeftButton"..i]
    button:ClearAllPoints()
    button:SetSize(C["actionbar"].buttonsize, C["actionbar"].buttonsize)
    if i == 1 then
      button:SetPoint("TOPLEFT", bar, 0,0)
    else
      local previous = _G["MultiBarLeftButton"..i-1]
      button:SetPoint("TOP", previous, "BOTTOM", 0, -C["actionbar"].buttonspacing)
    end
  end
  
  if C["actionbar"].bar5mouseover then
	--C["actionbar"].bar5fade = false
    -- local function lighton(alpha)
      -- if MultiBarLeft:IsShown() then
        -- for i=1, 12 do
          -- local pb = _G["MultiBarLeftButton"..i]
          -- pb:SetAlpha(alpha)
        -- end
      -- end
    -- end    
    -- bar:EnableMouse(true)
    -- bar:SetScript("OnEnter", function(self) lighton(1) end)
    -- bar:SetScript("OnLeave", function(self) lighton(0) end)
	bar:SetAlpha(0)
	bar:SetScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
    bar:SetScript("OnLeave", function(self) if not B.showbuttons or not C["actionbar"].bar5fade then UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end end)
    for i=1, 12 do
      local pb = _G["MultiBarLeftButton"..i]
      -- pb:SetAlpha(0)
      pb:HookScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
      pb:HookScript("OnLeave", function(self) if not B.showbuttons or not C["actionbar"].bar5fade then UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end end)
    end    
  end