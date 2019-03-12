local function BIMGFILTER(self,event,message,...)

	--print("[BIMG] "..message)
	
	if string.match(message, "%{{(.-)%}}") then
		if string.match(message, "%{{t") then
		--print("image")
		content = string.match(message, "%{{t(.-)%}}"):gsub("{{t", "{{")
		return false, "\124cff00ff00\124Hitem: 44940\124h\124T"..content..":0:0\124t\124h\124r",...;
		elseif string.match(message, "%{{cff") then
		content = string.match(message, "%{{cff%x%x%x%x%x%x(.-)%}}")
		colour = string.match(message, "%{{cff(%x%x%x%x%x%x)")
		return false, "\124cff"..colour..content.."\124r",...;
		
	end
end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", BIMGFILTER);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", BIMGFILTER);







