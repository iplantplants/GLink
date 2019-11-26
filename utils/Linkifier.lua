addonName, GLink = ...;

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
	--GPS is weird


	if ID and IDType and commandIndex then
		if IDType == "gameobject_GPS" then
			local x, y, z, ori, map = GLink:HandleMapCoordinates(ID, IDType);
				SendChatMessage("." .. GLink.hyperlinks[IDType]["COMMAND"][commandIndex]:match("^%w*") .. " " .. x .. " " .. y .. " " .. z .. " " .. map .. " " .. ori);
			return true;
		elseif IDType == "lnkfer" then
			
		else
			SendChatMessage("." .. GLink.hyperlinks[IDType]["COMMAND"][commandIndex]:gsub("%#"..IDType,ID));
			return true;
		end
	else
		return false;
	end
end

function GLink:HandleMapCoordinates(message, IDType)

	--print("MAP",message)

	local x, y, z, orientation, map;
	x = message:match(GLink.hyperlinks[IDType]["PATTERN"][1]);
	y = message:match(GLink.hyperlinks[IDType]["PATTERN"][2]);
	z = message:match(GLink.hyperlinks[IDType]["PATTERN"][3]);
	orientation = message:match(GLink.hyperlinks[IDType]["PATTERN"][4]);
	map = message:match("Map: (%d*)")

	if not orientation then
		orientation = message:match(GLink.hyperlinks[IDType]["PATTERN"][5]);
	else
		orientation = (orientation*math.pi/180);
	end

	if not x and not y and not z and not orientation and not map then
		x, y, z, orientation, map = message:match(GLink.hyperlinks["gameobject_GPS"]["PATTERN"][6]:gsub(IDType,""))
	end
	--print(x,y,z,orientation,map)
	return x, y, z, orientation, map;
end

function GLink:CopyMapCoordinates(message, IDType)

	local x, y, z, ori, map = GLink:HandleMapCoordinates(message, IDType);
	--print(x,y,z,ori,map)
	ChatFrame1EditBox:SetFocus()
		
		if ChatFrame1EditBox:GetText() == nil then
		
			ChatFrame1EditBox:SetText(x .. " " .. y .. " " .. z .. " " .. map .. " " .. ori)
		
		else

			ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .." " .. x .. " " .. y .. " " .. z .. " " .. map .. " " .. ori)

		end
	ChatFrame1EditBox:HighlightText()

end



