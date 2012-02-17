local cfg={}
cfg.stancealpha = true
cfg.HoT = true
cfg.font = "Fonts\\ZYKai_C.TTF"
cfg.cdalpha = 0.4
cfg.readyalpha = 1

--constants!
local function Round(v, decimals)
   if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(v)
end

local function RGBToHex(r, g, b)
   r = r <= 1 and r >= 0 and r or 0
   g = g <= 1 and g >= 0 and g or 0
   b = b <= 1 and b >= 0 and b or 0
   return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

OmniCC = true --hack to work around detection from other addons for OmniCC
local AddOnName = ...
local ICON_SIZE = 36 --the normal size for an icon (don't change this)
local DAY, HOUR, MINUTE = 86400, 3600, 60 --used for formatting text
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5 --used for formatting text at transition points
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5 --used for calculating next update times

--configuration settings
local FONT_FACE = cfg.font --what font to use
local FONT_SIZE = 20 --the base font size to use at a scale of 1
local MIN_SCALE = 0.5 --the minimum scale we want to show cooldown counts at, anything below this will be hidden
local MIN_DURATION = 2.5 --the minimum duration to show cooldown text for
local EXPIRING_DURATION = 3 --the minimum number of seconds a cooldown must be to use to display in the expiring format


local EXPIRING_FORMAT = RGBToHex(1,0,0)..'%.1f|r' --format for timers that are soon to expire
local SECONDS_FORMAT = RGBToHex(1,1,0)..'%d|r' --format for timers that have seconds remaining
local MINUTES_FORMAT = RGBToHex(1,1,1)..'%dm|r' --format for timers that have minutes remaining
local HOURS_FORMAT = RGBToHex(0.4,1,1)..'%dh|r' --format for timers that have hours remaining
local DAYS_FORMAT = RGBToHex(0.4,0.4,1)..'%dh|r' --format for timers that have days remaining

--local bindings!
local floor = math.floor
local min = math.min
local GetTime = GetTime

--returns both what text to display, and how long until the next update
local function getTimeText(s)
   --format text as seconds when below a minute
   if s < MINUTEISH then
      local seconds = tonumber(Round(s))
      if seconds > EXPIRING_DURATION then
         return SECONDS_FORMAT, seconds, s - (seconds - 0.51)
      else
         return EXPIRING_FORMAT, s, 0.051
      end
   --format text as minutes when below an hour
   elseif s < HOURISH then
      local minutes = tonumber(Round(s/MINUTE))
      return MINUTES_FORMAT, minutes, minutes > 1 and (s - (minutes*MINUTE - HALFMINUTEISH)) or (s - MINUTEISH)
   --format text as hours when below a day
   elseif s < DAYISH then
      local hours = tonumber(Round(s/HOUR))
      return HOURS_FORMAT, hours, hours > 1 and (s - (hours*HOUR - HALFHOURISH)) or (s - HOURISH)
   --format text as days
   else
      local days = tonumber(Round(s/DAY))
      return DAYS_FORMAT, days,  days > 1 and (s - (days*DAY - HALFDAYISH)) or (s - DAYISH)
   end
end

--stops the timer
local function Timer_Stop(self)
   self.enabled = nil
   self:Hide()
end

--forces the given timer to update on the next frame
local function Timer_ForceUpdate(self)
   self.nextUpdate = 0
   self:Show()
end

--adjust font size whenever the timer's parent size changes
--hide if it gets too tiny
local function Timer_OnSizeChanged(self, width, height)
   local fontScale = Round(width) / ICON_SIZE
   if fontScale == self.fontScale then
      return
   end

   self.fontScale = fontScale
   if fontScale < MIN_SCALE then
      self:Hide()
   else
      self.text:SetFont(FONT_FACE, fontScale * FONT_SIZE, 'OUTLINE')
      self.text:SetShadowColor(0, 0, 0, 0.5)
      self.text:SetShadowOffset(2, -2)
      if self.enabled then
         Timer_ForceUpdate(self)
      end
   end
end

--update timer text, if it needs to be
--hide the timer if done
local function Timer_OnUpdate(self, elapsed)
   if self.nextUpdate > 0 then
      self.nextUpdate = self.nextUpdate - elapsed
   else
      local remain = self.duration - (GetTime() - self.start)
      if remain > 0.01 then
         if (self.fontScale * self:GetEffectiveScale() / UIParent:GetScale()) < MIN_SCALE then
            self.text:SetText('')
            self.nextUpdate  = 1
         else
            local formatStr, time, nextUpdate = getTimeText(remain)
            self.text:SetFormattedText(formatStr, time)
            self.nextUpdate = nextUpdate
         end
      else
         Timer_Stop(self)
      end
   end
end

--returns a new timer object
local function Timer_Create(self)
   --a frame to watch for OnSizeChanged events
   --needed since OnSizeChanged has funny triggering if the frame with the handler is not shown
   local scaler = CreateFrame('Frame', nil, self)
   scaler:SetAllPoints(self)

   local timer = CreateFrame('Frame', nil, scaler); timer:Hide()
   timer:SetAllPoints(scaler)
   timer:SetScript('OnUpdate', Timer_OnUpdate)

   local text = timer:CreateFontString(nil, 'OVERLAY')
   text:SetPoint('CENTER', 1, 1)
   text:SetJustifyH("CENTER")
   timer.text = text

   Timer_OnSizeChanged(timer, scaler:GetSize())
   scaler:SetScript('OnSizeChanged', function(self, ...) Timer_OnSizeChanged(timer, ...) end)

   self.timer = timer
   return timer
end

local function OnSetCooldown(self, start, duration)
   if self.noOCC then return end
   --start timer
   if start > 0 and duration > MIN_DURATION then
      local timer = self.timer or Timer_Create(self)
      timer.start = start
      timer.duration = duration
      timer.enabled = true
      timer.nextUpdate = 0
      if timer.fontScale >= MIN_SCALE then timer:Show() end
   --stop timer
   else
      local timer = self.timer
      if timer then
         Timer_Stop(timer)
      end
   end
end

--[[ ActionUI Button ]]--

local actions, hooked = {}, {}
local function action_OnShow(self)
   actions[self] = true
end

local function action_OnHide(self)
   actions[self] = nil
end

local function action_Add(button, action, cooldown)
   if not hooked[cooldown] then
      cooldown:HookScript('OnShow', action_OnShow)
      cooldown:HookScript('OnHide', action_OnHide)
   end
   hooked[cooldown] = action
end

local function actions_Update()
   for cooldown in pairs(actions) do
        local start, duration = GetActionCooldown(hooked[cooldown])
        OnSetCooldown(cooldown, start, duration)
    end
end

local f = CreateFrame("Frame")
f:Hide()
f:SetScript('OnEvent', function(self, event, ...)
   if event == 'ACTIONBAR_UPDATE_COOLDOWN' then
      actions_Update()
   else
      if ... == AddOnName then
         hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, 'SetCooldown', OnSetCooldown)
         if cfg.HoT then
            hooksecurefunc('SetActionUIButton', action_Add)      
            for i, button in pairs(ActionBarButtonEventsFrame.frames) do
               action_Add(button, button.action, button.cooldown)
            end
         end
         self:UnregisterEvent('ADDON_LOADED')
      end
   end
end)

f:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
f:RegisterEvent("ADDON_LOADED")

if not cfg.cooldownalpha then return end

local function CDStop(frame)
   frame:SetScript("OnUpdate", nil)
   frame:SetAlpha(cfg.readyalpha)
   local index = frame:GetName():match("MultiCastActionButton(%d)")
   if index then
      _G["MultiCastSlotButton"..index]:SetAlpha(cfg.readyalpha)
   end
end

local function CDUpdate(frame)
   if frame.StopTime < GetTime() then
      CDStop(frame)
   else
      frame:SetAlpha(cfg.cdalpha)
      local index = frame:GetName():match("MultiCastActionButton(%d)")
      if index then
         _G["MultiCastSlotButton"..index]:SetAlpha(cfg.cdalpha)
      end
   end
end

local function UpdateCD(self)
   if not cfg.stancealpha and self:GetName():find("MultiCast") then return end
   local start, duration, enable = GetActionCooldown(self.action)
   if start>0 and duration > 1.5 then
      self.StopTime = start + duration
      self:SetScript("OnUpdate", CDUpdate)
   else
      CDStop(self)
   end
end

local function UpdateShapeshiftCD()
   for i=1, NUM_SHAPESHIFT_SLOTS do
      button = _G["ShapeshiftButton"..i]
      local start, duration, enable = GetShapeshiftFormCooldown(i)
      if start>0 and duration > 1.5 then
         button.StopTime = start + duration
         button:SetScript("OnUpdate", CDUpdate)
      else
         CDStop(button)
      end
   end
end

hooksecurefunc("ActionButton_UpdateState", UpdateCD)
hooksecurefunc("ActionButton_UpdateAction", UpdateCD)
if cfg.stancealpha then
   hooksecurefunc("ShapeshiftBar_UpdateState", UpdateShapeshiftCD)
end

if cfg.HoT then
   local function UpdateButtonsCD()
      for cooldown in pairs(actions) do
         UpdateCD(cooldown:GetParent())
      end
   end

   local cdalpha = CreateFrame("Frame")
   cdalpha:Hide()
   cdalpha:SetScript('OnEvent', function(self, event, ...)
      UpdateButtonsCD()
   end)

   cdalpha:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
end