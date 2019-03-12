--Linkifier_GPS

x, y, z, mapID, orientation = nil


local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)") and text:match("%[Teleport%]") and not IsModifiedClick() then
		x, y, z, mapID, orientation, entry = text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)|")
			return goToObject();
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Delete%]") and not IsModifiedClick() then
			guid = string.match(text, "|HGUID:(%d*)");
			return deleteGobjectGUID()
		elseif type(text) == "string" and text:match("|Hgobentry:") and text:match("%[Teleport%]") and not IsModifiedClick() then
			entry = string.match(text, "|Hgobentry:(%d*)")
			return goToObjectGUID()
		elseif type(text) == "string" and text:match("|Hgobentry:") and text:match("%[Select%]") and not IsModifiedClick() then
			entry = string.match(text, "|Hgobentry:(%d*)")
			return selectObject()
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Copy GUID%]") and not IsModifiedClick() then
			guid = string.match(text, "|HGUID:(%d*)");
			return copyGUID()
		elseif type(text) == "string" and text:match("%[Copy Coordinates%]") and not IsModifiedClick() then
			x, y, z, mapID, orientation = text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)|");
			return copyCoordinates(x, y, z, mapID, orientation)
		end
	
	
	return origChatFrame_OnHyperlinkShow(...); 
end


function copyCoordinates()
	--print(x,y,z,orientation,mapID)
	
	print("|cff"..LinkColour.."|h[Linkifier] |r|cff00ff00Copied object coordinates in format: X Y Z MAP ORIENTATION");
	
	ChatFrame1EditBox:SetFocus()
	
	if ChatFrame1EditBox:GetText() == nil then
	
		ChatFrame1EditBox:SetText(x.." "..y.." "..z.." "..mapID.." "..orientation)
	
	else

		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .." " .. x .. " " .. y .. " " .. z .. " " .. mapID .. " " .. orientation)

	end
ChatFrame1EditBox:HighlightText()
end

function copyGUID()

	ChatFrame1EditBox:SetFocus()
	if ChatFrame1EditBox:GetText() == nil then
		ChatFrame1EditBox:SetText(guid)
	else

		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .. " " ..guid)

	end
	ChatFrame1EditBox:HighlightText()

end

function goToObject()
	SendChatMessage(".worldport "..table.concat({x, y, z, mapID, orientation}, " "),"GUILD")
	DEFAULT_CHAT_FRAME:AddMessage("Teleported to object.")
	GameTooltip:Hide()
end

function selectObject()
	SendChatMessage(".gobject select "..entry, "GUILD")
	--print(entry)
	GameTooltip:Hide()
end

function goToObjectGUID()
	SendChatMessage(".gobject go "..entry, "GUILD")
	GameTooltip:Hide()
end

function deleteGobjectGUID()
	--SendChatMessage(".gobject select "..entry)
	SendChatMessage(".gobject delete "..guid, "GUILD")
	GameTooltip:Hide()
	end
--finds gobject select text
local function chatGPSFilter(self,event,message,...)
	messageCopy = message:gsub("%|cff%x%x%x%x%x%x", ""):gsub("|r", "")



	if string.match(message, "Selected gameobject") or string.match(message, "Spawned gameobject") then
		gobjectEntry = messageCopy:match("%[.+ - (%d*)%]")
		GUID = messageCopy:match("GUID: (%d*)")
		x = string.match(messageCopy, "at X: (%-?%d*%.?%d*)")
		y = string.match(messageCopy, "Y: (-?%d*\.?%d*)")
		z = string.match(messageCopy, "Z: (-?%d*\.?%d*)")
		mapID = string.match(messageCopy, "map (%d*)")
		orientation = string.match(messageCopy, "orientation: (-?%d*\.?%d*)")
		--print(gobjectEntry)
		return false, message.." - |cff"..LinkColour.."|Hx:"..x.."y:"..y.."z:"..z.."m:"..mapID.."o:"..orientation.."|h[Teleport]|h|r - |cff"..LinkColour.."|Hgameobject_entry:"..gobjectEntry.."|h[Spawn]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Delete]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Copy GUID]|h|r - |cff"..LinkColour.."|Hx:"..x.."y:"..y.."z:"..z.."m:"..mapID.."o:"..orientation.."|h[Copy Coordinates]|h|r",...;
		else if string.match(message, "X:(-?%d*\.?%d*) Y:(-?%d*\.?%d*) Z:(-?%d*\.?%d*) MapId:(%d*)") then
			entry, id = string.match(messageCopy,"(%d*) %(Entry: (%d*)%)")
			
			orientation = "0";
			--x, y, z, mapID = string.match(message, "X:(-?%d*\.?%d*) Y:(-?%d*\.?%d*) Z:(-?%d*\.?%d*) MapId:(%d*)")
			return false, message.."|cff"..LinkColour.."|Hgobentry:"..id.."|h[Select]|h|r - |cff"..LinkColour.."|Hgobentry:"..entry.."|h[Teleport]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Delete]|h|r",...;
		end
	end

	--GOBJ near
	if messageCopy:match("%[(.+) - (%d*)%] %(GUID:") then 
		entryID, GUID = messageCopy:match("%[.+ - (%d*)%] - %(GUID: (%d*)%)")
		--print("gobj near", entryID, GUID)
		return false, message.." - |cff"..LinkColour.."|Hgameobject_entry:"..entryID.."|h[Spawn]|h|r - |cff"..LinkColour.."|Hgobentry:"..GUID.."|h[Teleport]|h|r - |cff"..LinkColour.."|Hgobentry:"..entryID.."|h[Select]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Delete]|r",...;
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatGPSFilter);