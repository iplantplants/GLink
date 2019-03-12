--Linkifier_Worldport
--clickable hyperlink for .lo gobject results
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hcoords:") and not IsModifiedClick() then
			--objectID = string.match(text, "Hgameobject_entry:(%d*)");
			x, y, z, orientation, mapID = text:match("X(%-?%d*%.?%d*)Y(%-?%d*%.?%d*)Z(%-?%d*%.?%d*)ORI(%-?%d*%.?%d*)MAP(%d*)")
			return copyCoords();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function copyCoords()
	--print(x,y,z,orientation,mapID)
	
	print("|cff"..LinkColour.."|h[Linkifier] |r|cff00ff00Copied coordinates in format: X Y Z MAP ORIENTATION");
	
	ChatFrame1EditBox:SetFocus()
	
	if ChatFrame1EditBox:GetText() == nil then
	
		ChatFrame1EditBox:SetText(x.." "..y.." "..z.." "..mapID.." "..orientation)
	
	else

		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .. x .. " " .. y .. " " .. z .. " " .. mapID .. " " .. orientation)

	end
ChatFrame1EditBox:HighlightText()
end

--filter to find results in .lo gobject
local function chatLookupFilter(self,event,message,...)

	messageCopy = message:gsub("%|cff%x%x%x%x%x%x", ""):gsub("%|r", "")
	--messageCopy = messageCopy:gsub("%|r", "")
	
	if messageCopy:match("[mM]ap%:?%s%d*") then --and not messageCopy:match("%(Map:") then
		--print(messageCopy)
			map = messageCopy:match("[mM]ap%:?%s(%d*)")

	
	end

	if messageCopy:match("X: %-?%d*%.?%d*, Y: %-?%d*%.?%d*, Z: %-?%d*%.?%d*, O: %-?%d*%.?%d*") then
		
		x, y, z, orientation = messageCopy:match("X: (%-?%d*%.?%d*), Y: (%-?%d*%.?%d*), Z: (%-?%d*%.?%d*), O: (%-?%d*%.?%d*)")
		coords = "X"..x.."Y"..y.."Z"..z.."ORI"..orientation.."MAP"..map;
			--print(map, x, y, z, orientation)
		return false, message.." - |cff"..LinkColour.."|Hcoords:"..coords.."|h[Copy Coordinates]|h|r",...;
	end


	--coords = "X"..x.."Y"..y.."Z"..z.."ORI"..orientation.."MAP"..map;
	


end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);