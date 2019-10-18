--Linkifier_GPS

x, y, z, mapID, orientation = nil


local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)") and text:match("%[Teleport%]") and not IsModifiedClick() then
		
		x, y, z, mapID, orientation, entry = text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)|")
			return goToObject();
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Delete%]") and not IsModifiedClick() then
			local guid = string.match(text, "|HGUID:(%d*)");
			return deleteGobjectGUID(guid)
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Go%]") and not IsModifiedClick() then
			local guid = string.match(text, "|HGUID:(%d*)")

			return goToObjectGUID(guid)
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Select%]") and not IsModifiedClick() then
			local guid = string.match(text, "|HGUID:(%d*)")
			return selectObject(guid)
		elseif type(text) == "string" and text:match("|HGUID:") and text:match("%[Copy GUID%]") and not IsModifiedClick() then
			local guid = string.match(text, "|HGUID:(%d*)");
			return copyGUID(guid)
		elseif type(text) == "string" and text:match("%[Copy Coordinates%]") and not IsModifiedClick() then
			local x, y, z, mapID, orientation = text:match("Hx:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)|");
			return copyCoordinates(x, y, z, mapID, orientation)
		end
	
	
	return origChatFrame_OnHyperlinkShow(...); 
end


function copyCoordinates(x, y, z, mapID, orientation)
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

function copyGUID(guid)

	ChatFrame1EditBox:SetFocus()
	if ChatFrame1EditBox:GetText() == nil then
		ChatFrame1EditBox:SetText(guid:gsub("%s*",""))
	else

		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .. " " ..guid:gsub("%s*",""))

	end
	ChatFrame1EditBox:HighlightText()

end

function goToObject(x,y,z,mapID,orientation)
	SendChatMessage(".worldport "..table.concat({x, y, z, mapID, orientation}, " "),"GUILD")
	--DEFAULT_CHAT_FRAME:AddMessage("Teleported to object.")
	print("|cff00ccff[GLink]|r teleported to object.")
	GameTooltip:Hide()
end

function selectObject(guid)
	SendChatMessage(".gobject select "..guid, "GUILD")
	--print(entry)
	GameTooltip:Hide()
end

function goToObjectGUID(guid)
	SendChatMessage(".gobject go "..guid, "GUILD")
	print("|cff00ccff[GLink]|r teleported to object.")
	GameTooltip:Hide()
end

function deleteGobjectGUID(guid)
	--SendChatMessage(".gobject select "..entry)
	SendChatMessage(".gobject delete "..guid, "GUILD")
	GameTooltip:Hide()
	end

	function roundNum(num,numDecimal)
 
		local mult = 10^(numDecimal or 0);
		return math.floor(num*mult+0.5)/mult;
		 
	end

	function convertDegrees(arg)

		arg = arg*180/math.pi;
		arg = roundNum(tonumber(arg),4);
		--print(arg)
		return tostring(arg).."°";
	end

	function convertRadians(degrees)

		local radians = degrees * (math.pi/180)

		return radians
	end
--finds gobject select text
local function chatGPSFilter(self,event,message,...)
	messageCopy = message:gsub("%|cff%x%x%x%x%x%x", ""):gsub("|r", "")


	if string.match(message, "Selected gameobject") or string.match(message, "Spawned gameobject") and not string.match(message, "Spawned creature") then
		local gobjectEntry = messageCopy:match("%[.+ - (%d*)%]")
		local GUID = messageCopy:match("GUID: (%d*)")
	return false, message.." - |cff"..LinkColour.."|Hgameobject_entry:"..gobjectEntry.."|h[Spawn]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Select]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Go]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Delete]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Copy GUID]|h|r",...;

	elseif message:match("Position %(X:") then

		-- local x,y,z = messageCopy:match("X: (%-?%d*%.?%d*), Y: (%-?%d*%.?%d*), Z: (%-?%d*%.?%d*)")
		-- local orientation = messageCopy:match("Yaw/Turn: (%-?%d*%.?%d*)")
		-- --local mapID = messageCopy:match("MAP: (%d*)")
		-- local mapID = "1"
		-- print(x,y,z, orientation, convertRadians(tonumber(orientation)))

		-- return false, message.." - |cff"..LinkColour.."|Hx:"..x.."y:"..y.."z:"..z.."m:"..mapID.."o:"..orientation.."|h[Teleport]|h|r - |cff"..LinkColour.."|Hx:"..x.."y:"..y.."z:"..z.."m:"..mapID.."o:"..orientation.."|h[Copy Coordinates]|h|r",...;


	end

	--GOBJ near
	if messageCopy:match("%[(.+) - (%d*)%] %(GUID:") and not messageCopy:match("Spawned creature") then 
		local entryID, GUID = messageCopy:match("%[.+ - (%d*)%] - %(GUID: (%d*)%)")
		--print("gobj near", entryID, GUID)
		return false, message.." - |cff"..LinkColour.."|Hgameobject_entry:"..entryID.."|h[Spawn]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Go]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Select]|h|r - |cff"..LinkColour.."|HGUID:"..GUID.."|h[Delete]|h|r",...;
	end

	--gobj info


	--npc near


end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatGPSFilter);