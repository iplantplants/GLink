addon, GLink = ...;

--Debug

--Linkifier_Debug

print("Linkifier_Debug")


function GLink:HyperlinkHandler(ID,IDType,hyperlink)
	--print(ID,IDType,hyperlink)
	local hyperlink = GLink.colour.. "|H"..IDType..":"..ID.."|h"..hyperlink.."|h|r";

	return hyperlink;
end

function GLink:ExecuteCommand(ID,IDType,hyperlink)

	local commandIndex;
	--print(ID,IDType,hyperlink)
	for k,v in pairs(GLink.hyperlinks[IDType]["RETURNS"]) do
		if v == hyperlink then
			commandIndex = k;
			--print(ID,k,v,GLink.hyperlinks[IDType]["COMMAND"][k])
		end
	end
	if ID and IDType and commandIndex then
		SendChatMessage("." .. GLink.hyperlinks[IDType]["COMMAND"][commandIndex]:gsub("%#"..IDType,ID));
		return true;
	else
		return false;
	end
end






local function debugAddonMessageFilter(self,event,message,...)

	print(event,message)
	--print(message:gsub("|",""));

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_ADDON", debugAddonMessageFilter);

local input = {}
SLASH_GL1, SLASH_GL2 = '/gl', '/GL';
local function handler(message, editBox)
	for word in message do


	end
	
	-- local prefix = "EPSILON_G_PHASES";
	-- RegisterAddonMessagePrefix(prefix);
	-- SendAddonMessage(prefix)

end
SlashCmdList["GL"] = handler;