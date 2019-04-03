--Linkifier_Debug

print("Linkifier_Debug")




local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		
		if type(text) == "string" then
			--print("[Debug] "..link.." "..text);
			--return addItem();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

-- local function debugChatLookupFilter(self,event,message,...)


-- message = message:gsub("|","")

-- for i = 1, GetNumIgnores() do
-- 	if message:match(GetIgnoreName(i)) then
-- 		return true
-- 	end
-- end

-- --print(message)

-- end
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", debugChatLookupFilter);