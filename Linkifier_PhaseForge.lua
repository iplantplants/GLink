--Linkifier_PhaseForge

isForgeResult = false;

local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("Hforgecreature_entry:") and text:match("Delete") and not IsModifiedClick() then
            fGUID, fName = string.match(link, "forgecreature_entry:(%d*):forgecreatureName:(.+)")--:gsub("%[Delete%]", "");
            --print(link,text)
			return deleteForgedNPC(fGUID, fName);
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end



function deleteForgedNPC(forgedEntry, forgedName)
    --print("delete", forgedEntry, forgedName, "a")

    StaticPopupDialogs["CONFIRM_DELETE"] = {
        text = "Delete Forged NPC: |cff00ccff"..forgedName.."|r with ID: |cff00ccff"..forgedEntry.."|r?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            SendChatMessage(".ph forge npc delete "..forgedEntry, "GUILD")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
      }

      StaticPopup_Show("CONFIRM_DELETE")
	--SendChatMessage(".tele "..teleLoc, "GUILD")
end

local function chatLookupFilter(self,event,message,...)

    --message = message:gsub("|r","");
    messageCopy = message:gsub("|", "")
    if messageCopy:match("Forged NPCs for") and message:match("%[.+ - %d*%]") then

        isForgeResult = true;
        --print("forge list start")
    end
    if messageCopy:match("Found") and messageCopy:match("forged NPCs.") then

        isForgeResult = false;
        --print("forge list end")
    end

    --if message:match("[|cff00ccff(.+)|r%s-%s|cff00ccff(%d*)|r]|r") and isForgeResult == false then
        if isForgeResult == true and not message:match("Forged NPCs for") and not message:match("Found (.+) forged NPCs.") then
        --print(isForgeResult, "match")
        
        local messageCopy = message:gsub("|r",""):gsub("|", ""):gsub("cff%x%x%x%x%x%x", "")
        
        --print("Phase forge npc list:", message)
        --npcName = message:match("%[cff00CCFF(.+)r%s-");
        --npcID = message:match("%scff00CCFF(%d*)r");


            npcName, npcID = messageCopy:match("%[(.+) %- (%d*)%]")
            --print("name:",npcName, "ID", npcID)

            return false, message.." - |cff"..LinkColour.."|Hcreature_entry:"..npcID.."|h[Spawn]|h|r - |cff"..LinkColour.."|Hforgecreature_entry:"..npcID..":forgecreatureName:"..npcName.."|h[Delete]|h|r",...;
    end

    if isForgeResult == false and message:match("A template has been created for editing called") then

        local messageCopy = message:gsub("|r",""):gsub("|", ""):gsub("cff%x%x%x%x%x%x", "")
        local npcName, npcID = messageCopy:match("%[(.+) %- (%d*)%]");
        --print("NPC ID:",npcID, npcName)
        return false, message.." - |cff"..LinkColour.."|Hcreature_entry:"..npcID.."|h[Spawn]|h|r - |cff"..LinkColour.."|Hforgecreature_entry:"..npcID..":forgecreatureName:"..npcName.."|h[Delete]|h|r",...;

    end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", chatLookupFilter);