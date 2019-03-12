--Linkifier_Tele
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Htele:") and not IsModifiedClick() then
			teleLoc = string.match(text, "Htele:(%d*)");
			return teleToTele();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function teleToTele()
	SendChatMessage(".tele "..teleLoc, "GUILD")
end

local function chatLookupFilter(self,event,message,...)

	if string.match(message, "Htele:%d*") then
		creatureID = string.match(message, "Htele:(%d*)")
		return false, message.." - |cff"..LinkColour.."|Htele:"..creatureID.."|h[Teleport]|h|r",...;
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);