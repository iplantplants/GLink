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

	--.gobj lastspawn
	--print(message:gsub("|", ""), "lastsp")
	local messageCopy = message:gsub("|cff00CCFF",""):gsub("|r","");
	--print(messageCopy)
	if  messageCopy:match("Entry: (%d*)") and messageCopy:match("Guid: (%d*)") then
		--print("yeet")
		objectEntry = messageCopy:match("Entry: (%d*)");
		objectGUID = messageCopy:match("Guid: (%d*)");

		if objectEntry and objectGUID then
			return false, message.." - |cff"..LinkColour.."|Hgobentry:"..objectGUID.."|h[Select]|h|r - |cff"..LinkColour.."|Hgobentry:"..objectGUID.."|h[Teleport]|h|r",...;
		end
	end
	--Entry: |cff00CCFF841962|r - Guid: |cff00CCFF3415922|r


end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);