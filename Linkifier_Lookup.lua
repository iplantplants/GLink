--Linkifier_Lookup
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hln:") and not IsModifiedClick() then
			--print("next pls")
			return lookupNext();
		
		elseif type(text) == "string" and text:match("HemoteID:") and not IsModifiedClick() then
			--print("Emote")
			local emoteID = text:match("HemoteID:(%d*)");
			return PlayEmote(emoteID);
		end	
	return origChatFrame_OnHyperlinkShow(...); 
end

function PlayEmote(emoteID)
	print("Playing emote: |cff00ccff"..emoteID.."|r")
	SendChatMessage(".mod stand "..emoteID,"GUILD");

end

function lookupNext()
	SendChatMessage(".lookup next", "GUILD")
end

local function chatLookupFilter(self,event,message,...)


	
	messageCopy = message:gsub("|","");
	--print(messageCopy)

	if messageCopy:match("cff00CCFF%d*r %- cffADFFFF") and not messageCopy:match(".m2") then

		local emoteID = messageCopy:match("cff00CCFF(%d*)r %-");
		--print(emoteID)
		return false, message.." - |cff"..LinkColour.."|HemoteID:"..emoteID.."|h[Emote]|h|r",...;

	end

	if string.match(message, "Enter .lookup next to view the next 50 results") then
		creatureID = string.match(message, "Htele:(%d*)")
		return false, message.." - |cff"..LinkColour.."|Hln:1|h[Next]|h|r",...;
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);