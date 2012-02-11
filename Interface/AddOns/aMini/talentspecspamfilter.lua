
--[[
	Talent Spec Spam Filter
		By Azmenen of Kargath
]]



--------------------------------------------------------------------------------
--------------------------- GLOBAL VARIABLES ------------------------
--------------------------------------------------------------------------------

TSSF_addon = {};

local minTime = 1; -- the minimum time to allow for results to be collected.   NOTE: minTime seconds after TSSF_addon.time, the tables will be printed and then emptied
	
-- when the addon was last updated. 
	-- minTime seconds after TSSF_addon.time, the tables will be printed and then emptied
TSSF_addon.time = 8;


-- these localized patterns match the ways you learn/unlearn talents
TSSF_addon.patterns = {};

-- the string fragments for the patterns
TSSF_addon.patternFragments = {};

-- these are the tables that the messages will be stuffed into, each will be put in the appropriate table
TSSF_addon.unlearned = {};
TSSF_addon.learned = {};
TSSF_addon.learnedspell = {};
TSSF_addon.alreadyseen = {};

-- the localized strings for the TSSF_addon.patterns table
TSSF_addon.globalPatterns = {
	[1] = _G["ERR_SPELL_UNLEARNED_S"], -- You have unlearned %s.
	[2] = _G["ERR_LEARN_ABILITY_S"], -- You have learned a new ability : %s.
	[3] = _G["ERR_LEARN_SPELL_S"], -- You have learned a new spell : %s.
};

-- This table links patterns to the appropriate table
-- It is of the UTMOST IMPORTANCE that the indices in this link table match up with the indices in the globalPatterns table (both must be the same size and the links must link in the proper order)
TSSF_addon.link = {
	[1] = TSSF_addon.unlearned,
	[2] = TSSF_addon.learned,
	[3] = TSSF_addon.learnedspell,
};


-- Adds"(" and "+)" around the "%s" in the pattern strings
	-- This is necessary because the basic WoW parser won't correctly switch out the default symbols with the player's name
function TSSF_addon.addBetterStuff(in_string)
	local temp = string.gsub(in_string, "%%1$s", "(%%S+)");
	toReturn = string.gsub(temp, "%%s", "(%%S+)");
	
	return toReturn;
end

-- Adds"%" before the "."s in the input string
	-- This is necessary because the basic parser interprets "."s as wildcard characters, which is NOT desirable
function TSSF_addon.sanitizePeriods(in_string)
	local toReturn = "";
	for i=1, in_string:len() do
		if (in_string:sub(i,i) == ".") then
			toReturn = toReturn .. "%.";
		else
			toReturn = toReturn .. in_string:sub(i,i);
		end
	end
	return toReturn;
end

-- Breaks the input string into two parts, one is to the left of the "%s" and the other is to the right of the "%s". Neither part includes the "%s"
function TSSF_addon.makeFragments(in_string)
	local tbl = {
		[1] = "",
		[2] = "",
	};
	
	local value = "";
	local mod_string = TSSF_addon.sanitizePeriods(in_string);
	for i=1, mod_string:len() do
		if (mod_string:sub(i,i+1) == "%s") then
			tbl[1] = value;
			tbl[2] = mod_string:sub(i+2);
			return tbl;
		elseif (mod_string:sub(i,i+3) == "%1$s") then -- happens in German for some strings - ex: "Questlog von %1$s ist voll."
			tbl[1] = value;
			tbl[2] = mod_string:sub(i+4);
			return tbl;
		else
			value = value .. mod_string:sub(i,i);
		end
	end
	
	tbl[1] = mod_string;
	return tbl;
end





-- Populate the TSSF_addon.patterns table with the formatted Global String
for index, globalString in ipairs (TSSF_addon.globalPatterns) do
	TSSF_addon.patterns[index] = TSSF_addon.addBetterStuff(globalString);
	TSSF_addon.patternFragments[index] = TSSF_addon.makeFragments(globalString);
end





--------------------------------------------------------------------------------
-------------------------------- FUNCTIONS -----------------------------
--------------------------------------------------------------------------------

function TSSF_addon.debug()
	for index,globalString in ipairs (TSSF_addon.globalPatterns) do
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		DEFAULT_CHAT_FRAME:AddMessage("original: " .. globalString);
		DEFAULT_CHAT_FRAME:AddMessage("modded: '" .. TSSF_addon.patterns[index] .. "'");
		DEFAULT_CHAT_FRAME:AddMessage("fragments: '" .. TSSF_addon.patternFragments[index][1] .. "'    and    '" .. TSSF_addon.patternFragments[index][2] .. "'");
	end
end



-- Filters the Talent Spec Spam, adds messages to the appropriate table, and turns on the frame's OnUpdate
function TSSF_addon.TalentSpecSpamFilter(self, event, msg)
	for i=1, #(TSSF_addon.patterns) do
		if (msg:find(TSSF_addon.patterns[i])) then
			local tempString, finalString = "", "";
			
			if (TSSF_addon.patternFragments[i][1] ~= "") then
				tempString = string.gsub(msg, TSSF_addon.patternFragments[i][1], "");
			else tempString = msg;
			end
			
			if (TSSF_addon.patternFragments[i][2] ~= "") then
				finalString = string.gsub(tempString, TSSF_addon.patternFragments[i][2], "");
			else finalString = tempString;
			end
			
			-- Prevents repeating ourselves within the same message type
			if (TSSF_addon.alreadyseen[i] == nil) then TSSF_addon.alreadyseen[i] = {}; end
			if (TSSF_addon.alreadyseen[i][finalString] == nil) then
				TSSF_addon.alreadyseen[i][finalString] = true;
				
				local tempTable = TSSF_addon.link[i];
				tempTable[#(tempTable) + 1] = finalString;
				
				TSSF_addon.time = GetTime();
				TSSF_addon.frame:SetScript("OnUpdate", TSSF_addon.summarize);
			end
			
			return true;
		end
	end
	
	return false;
end

-- Returns a string of the contents of a table, separated by ", "
function TSSF_addon.print(intable)
	local toReturn = "";
	for k,name in pairs(intable) do
		toReturn = toReturn .. name .. ", ";
	end
	
	return toReturn;
end

-- Returns a string of the input string without the last comma
function TSSF_addon.removeLastComma(instring)
	local toReturn = "";
	
	for i=instring:len(), 1, -1 do
		if (instring:sub(i,i) == ",") then
			return instring:sub(1,i-1);
		end
	end
	
	return toReturn;
end

-- For every table that has values, prints that table's title and its values, then wipes the tables (to prevent repeated messages)
function TSSF_addon.summarize()
	if ((GetTime() - TSSF_addon.time) > minTime) then
		TSSF_addon.frame:SetScript("OnUpdate", nil);
		
		if (#(TSSF_addon.unlearned) > 0) then
			DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TSSF_addon.globalPatterns[1], "%%s", TSSF_addon.removeLastComma(TSSF_addon.print(TSSF_addon.unlearned))), 1, 1, 0);
		end
		
		if ((#(TSSF_addon.learned) > 0) or (#(TSSF_addon.learnedspell) > 0)) then
			DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TSSF_addon.globalPatterns[2], "%%s", TSSF_addon.removeLastComma(TSSF_addon.print(TSSF_addon.learned) .. TSSF_addon.print(TSSF_addon.learnedspell))), 1, 1, 0);
		end
		
		-- wipe all the tables, to prevent repeated messages
		for k, tbl in ipairs (TSSF_addon.link) do wipe(tbl); end
		wipe(TSSF_addon.alreadyseen);
	end
end




--------------------------------------------------------------------------------
---------------------------- FRAME VARIABLES ------------------------
--------------------------------------------------------------------------------

-- Create a frame so we can OnUpdate it
TSSF_addon.frame = CreateFrame("Frame", "TalentSpecSpamFilterFrame", UIParent);
TSSF_addon.frame:SetScript("OnUpdate", TSSF_addon.summarize);

-- Add the Talent Spec Spam Filter to the Chat Frame's Message Event Filter
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", TSSF_addon.TalentSpecSpamFilter);
