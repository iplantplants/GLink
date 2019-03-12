SLASH_GPLAY1, SLASH_GPLAY2 = '/gplay', '/gp';
local function handler(msg, editBox)

if msg == "1" then
	PlaySoundFile("INTERFACE\\AddOns\\GLink\\ref\\hellothere.mp3")
	SendChatMessage("nnyellow there", "SAY");
end

end
SlashCmdList["GPLAY"] = handler; -- Also a valid assignment strategy