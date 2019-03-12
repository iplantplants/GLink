--Linkifier items

local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hitem:") and text:match("%[Add%]") and not IsModifiedClick() then
			itemID = string.match(text, "Hitem:(%d*)");
			return addItem();
		
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function addItem()
	SendChatMessage(".additem "..itemID.." 1", "GUILD")
	GameTooltip:Hide()
end

local function chatLookupFilter(self,event,message,...)

	if string.match(message, "%[PHASE: %d*%]") or string.match(message, "Click here to join #%d*") then
		--print("Phase item"); do nothing
		else if string.match(message, "|Hitem:%d*") then
			itemID = string.match(message, "item:(%d*)")
			return false, message.." - |cff"..LinkColour.."|Hitem:"..itemID.."|h[Add]|h|r",...;
		end
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", chatLookupFilter);



