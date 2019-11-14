addonName, GLink = ...;

--
--  This is used to store quick and dirty variables used by various functions.
--





local getMap = CreateFrame("FRAME");
getMap:RegisterEvent("PLAYER_ENTERING_WORLD");
getMap:SetScript("OnEvent", function(self,event)
	reload = false;
	SendChatMessage(".gps", "GUILD")
end)