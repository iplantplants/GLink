--Linkifier_Gobjects
--clickable hyperlink for .lo gobject results
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hgameobject_entry:") and not IsModifiedClick() then
			objectID = string.match(text, "Hgameobject_entry:(%d*)");
			return spawnObject();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function spawnObject()
	SendChatMessage(".gobject spawn "..objectID.." 1", "GUILD")
end

--filter to find results in .lo gobject
local function chatLookupFilter(self,event,message,...)

	if string.match(message, "gameobject_entry:%d*") then
		objectID = string.match(message, "gameobject_entry:(%d*)")
		return false, message.." - |cff"..LinkColour.."|Hgameobject_entry:"..objectID.."|h[Spawn]|h|r",...;
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);