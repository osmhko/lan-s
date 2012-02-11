local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

local MFFade = CreateFrame("Button", nil, UI_Parent)
MFFade:Size(50,200)
MFFade:Point("TOPLEFT", UI_Parent, "TOPLEFT", 0, -0)
local MenuFrame = CreateFrame("Button", "JUIMenuFrame", MFFade)
--MenuFrame:CreatePanel("Default", 12, 300, "TOPLEFT", UI_Parent, "TOPLEFT", -6, -45)
MenuFrame:Size(12,100)
MenuFrame:Point("TOPLEFT", UI_Parent, "TOPLEFT", -6, -45)
local MFBG = CreateFrame("Frame",nil,MenuFrame)
MFBG:SetAllPoints(MenuFrame)
MFBG:SetFrameStrata("BACKGROUND")
MenuFrame.bg = MFBG:CreateTexture()
MenuFrame.bg:SetAllPoints(MenuFrame)
MenuFrame.bg:SetTexture(0,0,0,0.55)
local text = {}
for i = 1,3 do
text[i] = MenuFrame:CreateFontString(nil,"OVERLAY")
text[i]:SetFont(C.font, C.fontsize)
		text[i]:Point("LEFT",MenuFrame,"RIGHT",-3,26-22*(i-1))
		text[i]:SetTextColor(1,.8,0)
		text[i]:SetShadowColor(0,0,0)
		text[i]:SetShadowOffset(B.mult,-B.mult)
end
text[1]:SetText("主")
text[2]:SetText("菜")
text[3]:SetText("单")
--B.Reskin(MenuFrame)
UIFrameFadeIn(MFFade,1,1,0)

local menuFrame = CreateFrame("Frame", "m_MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {
        text = MAINMENU_BUTTON,
        isTitle = true,
        notCheckable = true,
    },
    {
        text = CHARACTER_BUTTON,
        icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function() 
            securecall(ToggleCharacter, 'PaperDollFrame') 
        end,
        notCheckable = true,
    },
    {
        text = SPELLBOOK_ABILITIES_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\Class',
        func = function() 
            securecall(ToggleSpellBook, BOOKTYPE_SPELL)
        end,
        notCheckable = true,
    },
    {
        text = TALENTS_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition',
        -- icon = 'Interface\\AddOns\\nMainbar\\media\\picomenu\\picomenuTalents',
        func = function() 
            securecall(ToggleTalentFrame) 
        end,
        notCheckable = true,
    },
    {
        text = ACHIEVEMENT_BUTTON,
        icon = 'Interface\\AddOns\\!JUI\\media\\picomenuAchievement',
        func = function() 
            securecall(ToggleAchievementFrame) 
        end,
        notCheckable = true,
    },
    {
        text = QUESTLOG_BUTTON,
        icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        func = function() 
            securecall(ToggleFrame, QuestLogFrame) 
        end,
        notCheckable = true,
    },
    {
        text = GUILD,
        icon = 'Interface\\GossipFrame\\TabardGossipIcon',
        arg1 = IsInGuild('player'),
        func = function() 
            if (IsInGuild('player')) then
                securecall(ToggleGuildFrame)
            else
                return
            end
        end,
        notCheckable = true,
    },
    {
        text = SOCIAL_BUTTON,
        icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
        func = function() 
            securecall(ToggleFriendsFrame, 1) 
        end,
        notCheckable = true,
    },
    {
        text = PLAYER_V_PLAYER,
        icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
        func = function() 
            securecall(ToggleFrame, PVPFrame) 
        end,
        notCheckable = true,
    },
    {
        text = DUNGEONS_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\None',
        func = function() 
            securecall(ToggleLFDParentFrame)
        end,
        notCheckable = true,
    },
    {
        text = RAID_FINDER,
        icon = 'Interface\\MINIMAP\\TRACKING\\None',
        func = function() 
            securecall(ToggleFrame, RaidParentFrame)
        end,
        notCheckable = true,
    },
    {
        text = RAID,
        icon = 'Interface\\TARGETINGFRAME\\UI-TargetingFrame-Skull',
        func = function() 
            securecall(ToggleFriendsFrame, 4)
        end,
        notCheckable = true,
    },
    {
        text = ENCOUNTER_JOURNAL,
        icon = 'Interface\\MINIMAP\\TRACKING\\Profession',
        func = function() 
            securecall(ToggleEncounterJournal)
        end,
        notCheckable = true,
    },
    {
        text = GM_EMAIL_NAME,
        icon = 'Interface\\TUTORIALFRAME\\TutorialFrame-QuestionMark',
        func = function() 
            securecall(ToggleHelpFrame) 
        end,
        notCheckable = true,
    },
    {
        text = BATTLEFIELD_MINIMAP,
        colorCode = '|cff999999',
        func = function() 
            securecall(ToggleBattlefieldMinimap) 
        end,
        notCheckable = true,
    },
}

local addonMenuTable = {
    {
        text = '',
        isTitle = true,
        notCheckable = true,
    },
    {   text = ADDONS, 
        hasArrow = true,
        notCheckable = true,
        menuList = {
            { 
                text = ADDONS, 
                isTitle = true,
                notCheckable = true,
            },
        } 
    }
}

local function UpdateAddOnTable()
    if (IsAddOnLoaded('VuhDo') and not v2) then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v2 = true
        addonMenuTable[2].menuList[n] = {
            text = 'VuhDo',
            func = function()
                SlashCmdList['VUHDO']('show')
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Grid') or IsAddOnLoaded('Grid2') and not v3) then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Grid', 
            func = function() 
                if (IsAddOnLoaded('Grid2')) then
                    ToggleFrame(Grid2LayoutFrame)
                elseif (IsAddOnLoaded('Grid')) then
                    ToggleFrame(GridLayoutFrame)
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Omen') and not v4) then   
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v4 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Omen', 
            func = function()
                if (IsShiftKeyDown()) then
                    Omen:Toggle()
                else
                    Omen:ShowConfig()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('PhoenixStyle') and not v5) then   
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v5 = true
        addonMenuTable[2].menuList[n] = { 
                text = 'PhoenixStyle', 
                func = function() 
                    ToggleFrame(PSFmain1) 
                    ToggleFrame(PSFmain2) 
                    ToggleFrame(PSFmain3)
                end,
                notCheckable = true,
                keepShownOnClick = true,
            }
    end

    if (IsAddOnLoaded('DBM-Core') and not v6) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v6 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'DBM', 
            func = function() 
                DBM:LoadGUI()
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Skada') and not v7) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v7 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Skada', 
            func = function() 
                Skada:ToggleWindow()
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Recount') and not v8) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v8 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Recount', 
            func = function() 
                ToggleFrame(Recount.MainWindow)
                if (Recount.MainWindow:IsShown()) then
                    Recount:RefreshMainWindow()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('TinyDPS') and not v9) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v9 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'TinyDPS', 
            func = function() 
                ToggleFrame(tdpsFrame)
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Numeration') and not v10) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v10 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Numeration', 
            func = function() 
                if (not IsShiftKeyDown()) then
                    ToggleFrame(NumerationFrame)
                else
                    NumerationFrame:ShowResetWindow() 
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('AtlasLoot') and not v11) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v11 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'AtlasLoot', 
            func = function() 
                ToggleFrame(AtlasLootDefaultFrame)
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (IsAddOnLoaded('Altoholic') and not v12) then  
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v12 = true
        addonMenuTable[2].menuList[n] = { 
            text = 'Altoholic', 
            func = function() 
                ToggleFrame(AltoholicFrame)
            end,
            notCheckable = true,
            keepShownOnClick = true,
        }
    end

    if (x and not x2) then
        table.insert(menuList, addonMenuTable[1])
        table.insert(menuList, addonMenuTable[2])
        x2 = true
    end
end

menuFrame:RegisterEvent('ADDON_LOADED')
menuFrame:SetScript('OnEvent', function()
    UpdateAddOnTable(arg1)
end)

local function MFMousein()
UIFrameFadeIn(MFFade,0.4,MFFade:GetAlpha(),1)
end
local function MFMouseout()
if not JUIMenuFrame:IsMouseOver() then UIFrameFadeIn(MFFade,0.4,MFFade:GetAlpha(),0)end
end
MFFade:SetScript("OnEnter",MFMousein)
MFFade:SetScript("OnLeave",MFMouseout)
MenuFrame:SetScript("OnMouseDown",function(self,_)
	UpdateAddOnTable(arg1)
	UIFrameFadeIn(MFFade,0.4,MFFade:GetAlpha(),0)
	securecall(EasyMenu, menuList, menuFrame, self, 0, 130, 'MENU', 8)
 end)

