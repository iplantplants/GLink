addonName, GLink = ...;

--Linkifier_Hover
local _G = getfenv(0)
local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip

local linktypes = {
    item         = true,
    instancelock = true,
    quest        = true,
    spell        = true,
}		

function OnHyperlinkEnter(frame, link, linkData, ...)
    --print(link, linkData)
    local linktype = link:match('^([^:]+)')
    --print(linktype,link,linkData)
    if link:match("ezc:") or link:match("PGUID:") or link:match("acc:") then
    --easycopy compatibility lol
    return false
    
    end
    if link:match("player:") or link:match("channel") then
        return false;
    end
    
    local IDType = link:match("(%w+%_?%s?%w*):%d*")
    local ID = link:gsub(IDType..":","")
    local hyperlink = linkData:match("(%[.+%])")
    local commandIndex;
    --print(link,linkData,"IDTYPE",IDType,ID, hyperlink)

    --get tooltip text


        for k,v in pairs(GLink.hyperlinks[IDType]["RETURNS"]) do
            if v == hyperlink then
                commandIndex = k;
                --print(ID,k,v,GLink.hyperlinks[IDType]["COMMAND"][k])
            end
        end


    
    if IDType and ID and hyperlink and commandIndex then
        --print(IDType,ID,hyperlink, commandIndex)
        --tooltipMessage = IDType .. " " .. ID .. " " .. hyperlink .. " " .. commandIndex;
        if IDType == "gameobject_GPS" then
            local x, y, z, ori, map = GLink:HandleMapCoordinates(":"..ID, IDType);
            --local output = string.format("Teleport to map %s%i|r at coordinates (X: %s%#.3f|r, Y: %s%#.3f|r, Z: %s%#.3f|r)", GLink.Colour, map, GLink.colour, x, GLink.colour, y, GLink.colour, z)

            local output = string.format("Teleport to map %s%i|r (X: %s%#.3f|r, Y: %s%#.3f|r, Z: %s%#.3f|r)", GLink.colour, map, GLink.colour, x, GLink.colour, y, GLink.colour, z)
            tooltipMessage = output;
            ShowToolTip();

        elseif linkData:match("%[Add%]") then
            GameTooltip:SetOwner(ChatFrame1, 'ANCHOR_CURSOR', 0, 20)
            GameTooltip:SetHyperlink(link)
            GameTooltip:Show()
        else

            tooltipMessage = GLink.hyperlinks[IDType]["TOOLTIP_TEXT"][commandIndex]:gsub("%#"..IDType,ID);
            ShowToolTip();
		end

    end
    

    if (orig1[frame]) then 
        return orig1[frame](frame, link, ...) 
    end
    
    end


local function OnHyperlinkClick(frame, ...)
    GameTooltip:Hide()
    if(orig2[frame]) then
        return orig2[frame](frame, ...)
    end
end

local function OnHyperlinkLeave(frame, ...)
    GameTooltip:Hide()
    if (orig2[frame]) then 
        return orig2[frame](frame, ...) 
    end
end

local function EnableItemLinkTooltip()
    for _, v in pairs(CHAT_FRAMES) do
        local chat = _G[v]
        if (chat and not chat.URLCopy) then
            orig1[chat] = chat:GetScript('OnHyperlinkEnter')
            chat:SetScript('OnHyperlinkEnter', OnHyperlinkEnter)

            orig2[chat] = chat:GetScript('OnHyperlinkLeave')
            chat:SetScript('OnHyperlinkLeave', OnHyperlinkLeave)
            chat.URLCopy = true
        end
    end
end
hooksecurefunc('FCF_OpenTemporaryWindow', EnableItemLinkTooltip)
EnableItemLinkTooltip()


function ShowToolTip()
GameTooltip:SetOwner(ChatFrame1, 'ANCHOR_CURSOR', 0, 20)
GameTooltip:ClearLines();
GameTooltip:AddLine(tooltipMessage,1,1,1,1,1,1)				
GameTooltip:Show()
end