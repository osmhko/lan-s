local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

if C["actionbar"].bar3mode == 1 then
	local bar = CreateFrame("Frame","_UIActionBar3",UIParent, "SecureHandlerStateTemplate")
	bar:SetFrameStrata("WORLD")
	bar:SetFrameLevel(1)
	MultiBarBottomRight:SetParent(bar)

	local bar1 = CreateFrame("Frame","_UIActionBar3_1",UIParent, "SecureHandlerStateTemplate")
	bar1:SetWidth(C["actionbar"].buttonsize*3+C["actionbar"].buttonspacing*2)
	bar1:SetHeight(C["actionbar"].buttonsize*2+C["actionbar"].buttonspacing)
	bar1:SetPoint("BOTTOMRIGHT", _UIActionBar1, "BOTTOMLEFT", -2*C["actionbar"].buttonspacing, 0)
	bar1:SetHitRectInsets(-C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset)
	bar1:SetScale(C["actionbar"].barscale)


	local bar2 = CreateFrame("Frame","_UIActionBar3_2",UIParent, "SecureHandlerStateTemplate")
	bar2:SetWidth(C["actionbar"].buttonsize*3+C["actionbar"].buttonspacing*2)
	bar2:SetHeight(C["actionbar"].buttonsize*2+C["actionbar"].buttonspacing)
	bar2:SetPoint("BOTTOMLEFT", _UIActionBar1, "BOTTOMRIGHT", 2*C["actionbar"].buttonspacing, 0)
	bar2:SetHitRectInsets(-C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset)
	bar2:SetScale(C["actionbar"].barscale)

	  
	local function in1()
		for i = 1,6 do
		local b = _G["MultiBarBottomRightButton"..i]
		UIFrameFadeIn(b,0.2,b:GetAlpha(),1) end
	end
	B.B31IN = in1
	local function in2()
		for i = 7,12 do
		local b = _G["MultiBarBottomRightButton"..i]
		UIFrameFadeIn(b,0.2,b:GetAlpha(),1) end
	end
	B.B32IN =  in2
	local function out1()
		if not B.showbuttons or not C["actionbar"].bar3_1fade then
			for i = 1,6 do
			local b = _G["MultiBarBottomRightButton"..i]
			UIFrameFadeIn(b,0.5,b:GetAlpha(),0) end
		end
	end
	B.B31OUT = out1
	local function out2()
		if not B.showbuttons or not C["actionbar"].bar3_2fade then
			for i = 7,12 do
			local b = _G["MultiBarBottomRightButton"..i]
			UIFrameFadeIn(b,0.5,b:GetAlpha(),0) end
		end
	end
	B.B32OUT = out2
	  
	for i=1, 6 do
		local button = _G["MultiBarBottomRightButton"..i]
		button:SetFrameStrata("MEDIUM")
		button:SetFrameLevel(3)
		button:SetSize(C["actionbar"].buttonsize, C["actionbar"].buttonsize)
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("TOPLEFT", bar1, 0,0)
		elseif i==4 then
			button:SetPoint("BOTTOMLEFT", bar1, 0,0)
		else
			local previous = _G["MultiBarBottomRightButton"..i-1]      
			button:SetPoint("LEFT", previous, "RIGHT", C["actionbar"].buttonspacing, 0)
		end
	end
	  
	for i=7, 12 do
		local button = _G["MultiBarBottomRightButton"..i]
		button:SetFrameStrata("MEDIUM")
		button:SetFrameLevel(3)
		button:SetSize(C["actionbar"].buttonsize, C["actionbar"].buttonsize)
		button:ClearAllPoints()
		if i == 7 then
			button:SetPoint("TOPLEFT", bar2, 0,0)
		elseif i==10 then
			button:SetPoint("BOTTOMLEFT", bar2, 0,0)
		else
			local previous = _G["MultiBarBottomRightButton"..i-1]      
			button:SetPoint("LEFT", previous, "RIGHT", C["actionbar"].buttonspacing, 0)
		end
	end
	if C["actionbar"].bar3_1mouseover then  
		out1()
		bar1:SetScript("OnEnter", in1)
		bar1:SetScript("OnLeave", out1)  
		for i=1, 6 do
			local pb = _G["MultiBarBottomRightButton"..i]
			pb:HookScript("OnEnter", in1)
			pb:HookScript("OnLeave", out1)
		end
	end
	if C["actionbar"].bar3_2mouseover then  
		out2()
		bar2:SetScript("OnEnter", in2)
		bar2:SetScript("OnLeave", out2)  
			for i=7, 12 do
				local pb = _G["MultiBarBottomRightButton"..i]
				pb:HookScript("OnEnter", in2)
				pb:HookScript("OnLeave", out2)
			end    
		end
else
	local bar = CreateFrame("Frame","_UIActionBar3_1",UIParent, "SecureHandlerStateTemplate")
	if C["actionbar"].bar3mode == 2 then
		bar:SetWidth(C["actionbar"].buttonsize*12+C["actionbar"].buttonspacing*11)
		bar:SetHeight(C["actionbar"].buttonsize)

		bar:SetPoint("BOTTOM", _UIActionBar2, "TOP", 0, C["actionbar"].buttonspacing)
	else
		bar:SetWidth(C["actionbar"].buttonsize*6+C["actionbar"].buttonspacing*5)
		bar:SetHeight(C["actionbar"].buttonsize*2+C["actionbar"].buttonspacing*1)

		bar:SetPoint("BOTTOMLEFT", _UIActionBar1, "BOTTOMRIGHT", C["actionbar"].buttonspacing, 0)
	end
	bar:SetHitRectInsets(-C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset, -C["actionbar"].barinset)

	bar:SetScale(C["actionbar"].barscale)



	MultiBarBottomRight:SetParent(bar)
	  
	for i=1, 12 do
		local button = _G["MultiBarBottomRightButton"..i]
		button:SetSize(C["actionbar"].buttonsize, C["actionbar"].buttonsize)
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("BOTTOMLEFT", bar, 0, 0)
		elseif i == 7 and C["actionbar"].bar3mode ~= 2 then
			button:SetPoint("TOPLEFT", bar, 0, 0)
		else
			local previous = _G["MultiBarBottomRightButton"..i-1]      
			button:SetPoint("LEFT", previous, "RIGHT", C["actionbar"].buttonspacing, 0)
		end
	end
	  
if C["actionbar"].bar3_1mouseover then
	bar:SetAlpha(0)
	bar:SetScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
	bar:SetScript("OnLeave", function(self) if not B.showbuttons or not C["actionbar"].bar3_1fade then UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end end)
		for i=1, 12 do
			local pb = _G["MultiBarBottomRightButton"..i]
			pb:HookScript("OnEnter", function(self) UIFrameFadeIn(bar,0.5,bar:GetAlpha(),1) end)
			pb:HookScript("OnLeave", function(self) if not B.showbuttons or not C["actionbar"].bar3_1fade then UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) end end)
		end    
	end
end