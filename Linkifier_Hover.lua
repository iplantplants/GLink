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
			if link:match("ezc:") then
			--easycopy compatibility lol
			return false
			
			end
			--print(link,linkData)
			if linkData:match("%[Add%]") then
				--print("Add works")
				GameTooltip:SetOwner(ChatFrame1, 'ANCHOR_CURSOR', 0, 20)
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
				--if linkData:match("%[Add%]") and link:match
			elseif linkData:match("%[Learn%]") or linkData:match("%[Cast%]") or linkData:match("%[Aura%]") or linkData:match("%[Unaura%]") then
				GameTooltip:SetOwner(ChatFrame1, 'ANCHOR_CURSOR', 0, 20)
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
			elseif linkData:match("%[Phase: %d*%]") then
				phaseID = linkData:match("%[Phase: (%d*)%]")
				tooltipMessage = "Click to enter phase "..phaseID;
				ShowToolTip()
			elseif linkData:match("%[Teleport%]") and not link:match("gobentry:") then
				if link:match("tele:") then
					--print(link, linkData)
					teleloc = link:match("tele:(%d*)")
					tooltipMessage = "Teleport to "..teleloc;
				else
				--print(link, linkData)
				x = string.match(link, "x:(%-?%d*\.?%d*)")
				y = string.match(link, "y:(-?%d*\.?%d*)")
				z = string.match(link, "z:(-?%d*\.?%d*)")
				m = string.match(link, "m:(%d*)")
				o = string.match(link, "o:(-?%d*\.?%d*)")
				tooltipMessage = "Teleport coordinates: X: "..x.. "Y: "..y.." Z: "..z.." map: "..m.." orientation: "..o;
				end
				ShowToolTip()
				--print("Phase: ",phaseID)
			elseif linkData:match("%[Delete%]") and not link:match("NGUID") then
				entryID = link:match("GUID:(%d*)")
				tooltipMessage = "Delete GameObject with GUID: "..entryID;
				ShowToolTip()
			elseif linkData:match("%[Select%]") then
				
				entryID = link:match("gobentry:(%d*)")
				tooltipMessage = "Select GameObject with GUID: "..entryID;
				ShowToolTip()
			
			elseif linkData:match("%[Teleport%]") and link:match("gobentry:") then
				entry = link:match("gobentry:(%d*)")
				tooltipMessage = "Teleport to GameObject with GUID: "..entry;
				ShowToolTip()
			elseif linkData:match("%[Spawn%]") then
				--print(linkData, link)
				if link:match("creature_entry") then --creature
					entryID = link:match("creature_entry:(%d*)")
					tooltipMessage = "Spawn creature with ID: "..entryID;
				else
				entryID = link:match("gameobject_entry:(%d*)")
				tooltipMessage = "Spawn GameObject with ID: "..entryID;
				end
				ShowToolTip()
			elseif linkData:match("%[Copy GUID%]") then
				GUID = link:match("GUID:(%d*)")
				tooltipMessage = "Copy GUID to chat with ID: "..GUID;
				ShowToolTip()
			elseif linkData:match("%[Copy Coordinates%]") then
				tooltipMessage = "Copy GPS coordinates to chat.";
				ShowToolTip()
			elseif linkData:match("%[Copy URL%]") then
				URL = link:gsub("lnkfer: ", "");
				tooltipMessage = "Copy URL to chat.";
				ShowToolTip();
			elseif linkData:match("%[Morph%]") then
				displayID = link:match("displayID:(%d*)");
				tooltipMessage = "Morph into displayID: "..displayID;
				ShowToolTip();
			elseif linkData:match("%[Mount%]") then
				displayID = link:match("displayID:(%d*)");
				tooltipMessage = "Mount displayID: "..displayID;
				ShowToolTip();
			elseif link:match("NGUID") and linkData:match("%[Delete%]") then
				NGUID = link:match("NGUID:(%d*)")
				tooltipMessage = "Remove creature with GUID: "..NGUID;
				ShowToolTip();
			elseif linkData:match("%[Next%]") then
				tooltipMessage = "Click to display the next 50 lookup results."
				ShowToolTip();
			elseif linkData:match("skybox") and linkData:match("%[Preview%]") then
				skyBoxID = linkData:match("skybox:(%d*)");
				tooltipMessage = "Click to preview skybox with ID: "..skyBoxID;
				ShowToolTip();	
			elseif linkData:match("%[Copy Coordinates%]") then
				tooltipMessage = "Click to copy coordinates to chat";
				ShowToolTip();		
			else
				GameTooltip:Hide()
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