﻿local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	local c = 0
	for b=0,4 do
		for s=1,GetContainerNumSlots(b) do
			local l = GetContainerItemLink(b, s)
			if l then
				local p = select(11, GetItemInfo(l))*select(2, GetContainerItemInfo(b, s))
				if select(3, GetItemInfo(l))==0 and p>0 then
					UseContainerItem(b, s)
					PickupMerchantItem()
					c = c+p
				end
			end
		end
	end
	if c>0 then
		local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
		DEFAULT_CHAT_FRAME:AddMessage("您背包内的粗糙物品已被自动卖出, 您赚取了".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r.",255,255,0)
	end
	if not IsShiftKeyDown() then
		if CanMerchantRepair() then
			local cost, possible = GetRepairAllCost()
			if cost>0 then
				if possible then
					local c = cost%100
					local s = math.floor((cost%10000)/100) or 0
					local g = math.floor(cost/10000) or 0
					if IsInGuild() and CanGuildBankRepair() and ((GetGuildBankWithdrawMoney() >= cost) or (GetGuildBankWithdrawMoney() == -1)) and (GetGuildBankMoney() >= cost) then
						RepairAllItems(1)						
						DEFAULT_CHAT_FRAME:AddMessage("您的装备已使用工会修理, 花费了".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r.",255,255,0)
					elseif GetMoney() >= cost then
						RepairAllItems()
						DEFAULT_CHAT_FRAME:AddMessage("您的装备已修理, 花费了".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r.",255,255,0)
					else
						DEFAULT_CHAT_FRAME:AddMessage("您没有足够的金钱来修理!",255,0,0)
						return
					end
				end
			end
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")