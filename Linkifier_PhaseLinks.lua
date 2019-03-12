--Linkifier_PhaseLinks


local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("|HphaseID:") and not text:match("|Hitem:%d%d%d%d%d%d%d%d%d%d") and not IsModifiedClick() then
			phaseNo = string.match(text, "HphaseID:(%d*)");
			return phaseLink();
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function phaseLink()
	SendChatMessage(".phase enter "..phaseNo, "GUILD")
	--_G(GameTooltip:Hide())
	GameTooltip:Hide()
end




local function chatPhaseFilter(self,event,message,sender,...)
	
	--get channel colour
if string.match(message, "Phase %d* has %d* members") then
				--do nothing
				
else
	if event == "CHAT_MSG_SYSTEM" and string.match(message, "%:%|?%r?%s? |cff%x%x%x%x%x%x%|?") and not string.match(message, "%[%EVENT%]") and not string.match(message, "%[%GUILD%]")then
		--print("seeing coloour")
		colourCode = string.match(message, "%:%|?%r?%s? |cff(%x%x%x%x%x%x)%|?")
		--print(colourCode)
		else if string.match(message, "%[%EVENT%]") or string.match(message, "%[%GUILD%]")then
			--print("event")
			colourCode = string.match(message, "|cff(%x%x%x%x%x%x)%|?")
			--print("event: "..colourCode)

		end
	end

	if string.match(message, "(%Phase%s?%d)") and not message:match("|Hitem:%d%d%d%d%d%d%d%d%d%d") then
		if string.match(message, "%bpe%:?%-?%s?(%d+)") then --
			phaseNo = string.match(message, "%bpe%:?%-?%s?(%d+)");
			if event == "CHAT_MSG_SYSTEM" then
				message = message:gsub("%Phase%:?%-?%s?(%d+)","|cff"..LinkColour.."|HphaseID:"..phaseNo.."|h[Phase: "..phaseNo.."]|h|r|cff"..colourCode.."|h")
			else
				message = message:gsub("%Phase%:?%-?%s?(%d+)","|cff"..LinkColour.."|HphaseID:"..phaseNo.."|h[Phase: "..phaseNo.."]|h|r")	
			end
			if phaseNo == "" then
				--do nothing
			else
				--return false, message.." \124cff29a3a3\124HphaseID: "..phaseNo.."\124h[Phase: "..phaseNo.."]\124h\124r", sender,...;
				return false, message, sender,...;
			end
		end		
	else
	end
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", chatPhaseFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatPhaseFilter);