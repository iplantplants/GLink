--Linkifier_Creature

--Linkifier_Gobjects
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("HNGUID:") and not IsModifiedClick() then
			GUID = string.match(text, "HNGUID:(%d*)");
			return deleteNPC();
		elseif type(text) == "string" and text:match("HdisplayID") and not IsModifiedClick() then
			displayID = string.match(text, "HdisplayID:(%d*)")
			if text:match("%[Mount%]") then
				return mountDisplay()
			else
				return morphDisplay()
			end
			
			
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function deleteNPC()
	SendChatMessage(".npc delete "..GUID, "GUILD")
end

function morphDisplay()
	SendChatMessage(".morph "..displayID)
end

function mountDisplay()
	SendChatMessage(".mod mount "..displayID)
end

local function chatLookupFilter(self,event,message,...)
	
	messageCopy = message:gsub("%|cff%x%x%x%x%x%x", ""):gsub("%|r", "")
	--print(messageCopy)
	if string.match(messageCopy, "Selected NPC:") then
		--print("npc info")
		--creatureID = string.match(message, "Hcreature_entry:(%d*)")
		GUID, entryID = messageCopy:match("GUID: (%d*), Entry: (%d*)")
		displayID = messageCopy:match("DisplayID: (%d*)")
		--print(GUID, entryID, displayID)
		return false, message.." - |cff"..LinkColour.."|Hcreature_entry:"..entryID.."|h[Spawn]|h|r - |cff"..LinkColour.."|HNGUID:"..GUID.."|h[Delete]|h|r - |cff"..LinkColour.."|HdisplayID:"..displayID.."|h[Morph]|h|r - |cff"..LinkColour.."|HdisplayID:"..displayID.."|h[Mount]|h|r",...;
	

	elseif messageCopy:match("Spawned creature") then
		entryID, GUID = messageCopy:match("(%d*)%] %(GUID: (%d*)%)")
		--print(entryID, GUID)
		--print("Registered creature creation. Work in progress")
		return false, message.." - |cff"..LinkColour.."|Hcreature_entry:"..entryID.."|h[Spawn]|h|r - |cff"..LinkColour.."|HNGUID:"..GUID.."|h[Delete]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Copy GUID]|h|r",...;
		
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);