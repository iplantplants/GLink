--Linkifier_Skybox

--Linkifier_Gobjects
local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hskybox:") and not IsModifiedClick() then
			skyBoxID = string.match(text, "Hskybox:(%d*)");
			return setSkybox();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function setSkybox()

SendChatMessage(".phase set skybox map "..skyBoxID, "GUILD");

end


local function chatLookupFilter(self,event,message,...)
	
	--messageCopy = message:gsub("|", ""):gsub("cff", "")
	--print(messageCopy)
	--print(messageCopy) -- %d* - |cff00CCFF
	if messageCopy:match("%d* - 00CCFF%[.+%]r") and not messageCopy:match("%d* - 00CCFF%[.+%]%r.") then -- it's a skybox

	skyBoxID = messageCopy:match("(%d*)")
	--print(skyBoxID)
	return false, message.." - |cff"..LinkColour.."|Hskybox:"..skyBoxID.."|h[Preview]|h|r",...;

	end
	

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);