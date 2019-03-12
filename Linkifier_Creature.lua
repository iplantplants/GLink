--Linkifier_Creature

--Linkifier_Gobjects
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hcreature_entry:") and not IsModifiedClick() then
			creatureID = string.match(text, "Hcreature_entry:(%d*)");
			return spawnNPC();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function spawnNPC()
	SendChatMessage(".npc spawn "..creatureID.." 1", "GUILD")
end

local function chatLookupFilter(self,event,message,...)
	

	if string.match(message, "Hcreature_entry:%d*") then
		creatureID = string.match(message, "Hcreature_entry:(%d*)")
		return false, message.." - |cff"..LinkColour.."|Hcreature_entry:"..creatureID.."|h[Spawn]|h|r",...;
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);