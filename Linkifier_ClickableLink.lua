-- Print information about a clicked hyperlink

--Filter for URL hyperlinks

print("Click me: \124cff5cd6d6\124Hitem:8191:0:0:0:0:0:0:0:0:1\124h[How to Link]\124h\124r");

local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("%[How to Link%]") and not IsModifiedClick() then
			return ShowLinkTip()
			else if type(text) == "string" and link:match("lnkfer: ") and not IsModifiedClick() then		
				url = link:gsub("lnkfer: ", "")
				ChatFrame1EditBox:SetFocus()
				ChatFrame1EditBox:SetText(url)
				ChatFrame1EditBox:HighlightText()
				--return ShowURL()
			end
		end
		
	return origChatFrame_OnHyperlinkShow(...); 
end
--debug

local function addLine(a, ...) 
 if a then
  return ItemRefTooltip:AddLine(a,1,1,1,1), addLine(...);
 end
end



--Show tooltip

function ShowLinkTip()
	ShowUIPanel(ItemRefTooltip);
	if (not ItemRefTooltip:IsVisible()) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
	end
	ItemRefTooltip:ClearLines();
	addLine("\124cff0070ddHow to Link\124r", "");
	ItemRefTooltip:AddDoubleLine("Linkifier","Tooltip",1,1,1,1,1,1);
	addLine("Click on the coloured URL to open up a text box that will enable you to copy the link.");
	addLine("Press Enter or Escape to close the text box that appears.")
	ItemRefTooltip:Show(); ItemRefTooltip:Show();
end



