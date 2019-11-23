--
--
--
GLink.channel = "xtensionxtooltip2";
local channelID = GetChannelName(GLink.channel)
local function debugAddonMessageFilter(self,event,message,...)

	--print("GLINK:", event,message,sender)
	--print(message:gsub("|",""));

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_ADDON", debugAddonMessageFilter);

local input = {}
SLASH_GL1, SLASH_GL2 = '/gl', '/GL';
local function handler(message, editBox)

local messageContents = {}
local arg = ""; 
for word in message:gmatch("[^%s]+") do
	table.insert(messageContents, word)
end

for i = 2, table.getn(messageContents) do
	arg = arg .. messageContents[i];
end
EpsilonMessage(tonumber(messageContents[1]),arg)

	
	-- local prefix = "EPSILON_G_PHASES";
	-- RegisterAddonMessagePrefix(prefix);
	-- SendAddonMessage(prefix)

end
SlashCmdList["GL"] = handler;

local prefixes = {
	[1] = "EPSILON_G_PHASES",
    [2] = "EPSILON_G_INFO",
    [3] = "EPSILON_G_LOGS",
	[4] = "EPSILON_TYPING",
	[5] = "EPSILON_P_MAP",
	[6] = "EPSILON_G_SKBX",
	[7] = "EPSILON_S_PRVCY",
	[8] = "EPSILON_S_NAME",
	
}

function EpsilonMessage(prefix, message)

print(prefixes[prefix], message)
RegisterAddonMessagePrefix(prefixes[prefix])

SendAddonMessage(prefixes[prefix], message, "CHANNEL", channelID)

end

local init = CreateFrame("FRAME");
init:RegisterEvent("PLAYER_ENTERING_WORLD");
init:SetScript("OnEvent", function(self,event)

    JoinChannelByName(GLink.channel)

end);