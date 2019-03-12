--Linkifier_Lookup
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hln:") and not IsModifiedClick() then
			--print("next pls")
			return lookupNext();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function lookupNext()
	SendChatMessage(".lookup next", "GUILD")
end

local function chatLookupFilter(self,event,message,...)

	if string.match(message, "Enter .lookup next to view the next 50 results") then
		creatureID = string.match(message, "Htele:(%d*)")
		return false, message.." - |cff"..LinkColour.."|Hln:1|h[Next]|h|r",...;
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);