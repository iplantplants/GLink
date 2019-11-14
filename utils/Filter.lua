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
						--print("match hyperlink")
						
						if link:match(v["PATTERN"][i]) and not ID then
							ID = link:match(v["PATTERN"][i]);
						end
						IDType = k;
						hyperlink = text:match("(%[.+%])")
					end
				end
            end
            print(link,text,ID,IDType,hyperlink)
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
			
            return origChatFrame_OnHyperlinkShow(...)
		end		
	return origChatFrame_OnHyperlinkShow(...);
end


local function debugChatLookupFilter(self,event,message,...)

	--print(message:gsub("|",""))

	for k,v in pairs(GLink.hyperlinks) do
		local ID, IDType;
		for i = 1, table.getn(v["PATTERN"]) do
			--print((v["PATTERN"][i]))
			if message:match(v["PATTERN"][i]) and not ID and not IDType then --:gsub("%(",""):gsub("%)","")
				--print("match")
				ID = message:match(v["PATTERN"][i]);
				IDType = k;
				--print(ID,k)
			end
		end
		if ID and IDType then
			for k,v in pairs(GLink.hyperlinks[IDType]["RETURNS"]) do
				message = message .. GLink.altColour .. " -|r " ..  GLink:HyperlinkHandler(ID,IDType,v)
			end
		end
	end
	--print(ID,IDType)

	return false, message,...;
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", debugChatLookupFilter);

