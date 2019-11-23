--
--
--
addonName, GLink = ...;

local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and not IsModifiedClick() then
			local ID, IDType;
			--print(text,link)
			for k,v in pairs(GLink.hyperlinks) do
				for i = 1, table.getn(v["PATTERN"]) do
					if link:match(v["PATTERN"][i]:gsub("%(",""):gsub("%)","")) then
						
						if link:match(v["PATTERN"][i]) and not ID then
							ID = link:match(v["PATTERN"][i]);
						end
						IDType = k;
						hyperlink = text:match("(%[.+%])")
					end
				end
            end
			--print(link,text,ID,IDType,hyperlink, "DEBUG")

			if link:match("gameobject_GPS") then
				IDType = "gameobject_GPS";
				ID = link:gsub(IDType, "");
				hyperlink = text:match("(%[.+%])")
			end
			if text:match("X:-?%d*\.?%d*") then
				ID = link;
				IDType = "gameobject_GPS";
				hyperlink = text:match("(%[.+%])");
				--GLink:ExecuteCommand(text, "gameobject_GPS", "[Teleport]")
			end
			--Make an exception for lookup next. smh
			if text:match("lookup next") then
				ID = 50;
				IDType = "lookup next";
				hyperlink = "[Next]"
			end
			
			--print(ID,IDType,hyperlink,link,text)
			if ID and IDType and hyperlink then
				GLink:ExecuteCommand(ID,IDType,hyperlink)
				return false;
			end
		elseif type(text) == "string" and IsModifiedClick() then
			print("modified")
			if link:match("gameobject_GPS") then
				IDType = "gameobject_GPS";
				ID = link:gsub(IDType, "");
				hyperlink = text:match("(%[.+%])")
				GLink:CopyMapCoordinates(ID, IDType)
			end
			if text:match("X:-?%d*\.?%d*") then
				ID = link;
				IDType = "gameobject_GPS";
				hyperlink = text:match("(%[.+%])");
				GLink:CopyMapCoordinates(ID, IDType)

				--GLink:ExecuteCommand(text, "gameobject_GPS", "[Teleport]")
			end

		end

	return origChatFrame_OnHyperlinkShow(...);
end


local function debugChatLookupFilter(self,event,message,...)
	local x, y, z, orientation;
	--print(message:gsub("|","~"))

	for k,v in pairs(GLink.hyperlinks) do
		local ID, IDType;
		for i = 1, table.getn(v["PATTERN"]) do
			if message:match(v["PATTERN"][i]) and not ID and not IDType then --:gsub("%(",""):gsub("%)","")
				ID = message:match(v["PATTERN"][i]);
				IDType = k;
			end
		end
		if ID and IDType then
			print(ID,IDType)
			for k,v in pairs(GLink.hyperlinks[IDType]["RETURNS"]) do
				if IDType == "gameobject_GPS" then
					x, y, z, orientation = GLink:HandleMapCoordinates(message, IDType)					
				else
					message = message .. GLink.altColour .. " -|r " ..  GLink:HyperlinkHandler(ID,IDType,v)
				end
			end
			if x and y and z and orientation then
				message = message .. GLink.altColour .. " -|r ".. GLink.colour .. "|Hgameobject_GPS:" .. x .. ":" .. y .. ":" .. z .. ":" .. orientation .. ":" .. GLink.currentMap .. "|h[Teleport]|h|r";
			end
		end
	end
	return false, message,...;
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", debugChatLookupFilter);

