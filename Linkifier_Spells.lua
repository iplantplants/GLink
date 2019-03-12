--Linkifier spells

local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("|Hspell:") and text:match("%[Learn%]") and not IsModifiedClick() then
			spellID = string.match(text, "|Hspell:(%d*)");
			return learnSpell();
		elseif type(text) == "string" and text:match("|Hspell:") and text:match("%[Cast%]") and not IsModifiedClick() then
			spellID = string.match(text, "|Hspell:(%d*)");
			return castSpell();
		elseif type(text) == "string" and text:match("|Hspell:") and text:match("%[Aura%]") and not IsModifiedClick() then
			spellID = string.match(text, "|Hspell:(%d*)");
			return auraSpell();
		elseif type(text) == "string" and text:match("|Hspell:") and text:match("%[Unaura%]") and not IsModifiedClick() then
			spellID = string.match(text, "|Hspell:(%d*)");
			return unauraSpell();
end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function learnSpell()
	SendChatMessage(".learn "..spellID, "GUILD")
	GameTooltip:Hide()
end
function castSpell()
	SendChatMessage(".cast "..spellID, "GUILD")
	GameTooltip:Hide()
end
function auraSpell()
	SendChatMessage(".aura "..spellID, "GUILD")
	GameTooltip:Hide()
end
function unauraSpell()
	SendChatMessage(".unaura "..spellID)
	GameTooltip:Hide()
end

local function chatLookupFilter(self,event,message,...)

	if string.match(message, "|Hspell:%d*") then
		spellID = string.match(message, "Hspell:(%d*)")
		--print("Spell: "..spellID)
		if string.match(message, "%[active%]") then
			return false, message .. " - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Learn]|h|r - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Cast]|h|r - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Unaura]|h|r",...;
		else
		return false, message.." - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Learn]|h|r - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Cast]|h|r - |cff"..LinkColour.."|Hspell:"..spellID.."|h[Aura]|h|r",...;
		end
end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);