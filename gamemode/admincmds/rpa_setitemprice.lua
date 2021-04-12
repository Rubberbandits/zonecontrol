local function ChangeItemPrice(ply, args)
	if #args == 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: no id specified.")
		return
	end

	local itemID = args[1]
	local metaitem = GAMEMODE:GetItemByID(itemID)
	if !metaitem then
		ply:Notify(nil, COLOR_ERROR, "Error: invalid item specified.")
		return
	end

	local newPrice = tonumber(args[2])
	if !newPrice or newPrice <= 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: invalid price specified.")
		return
	end

	GAMEMODE.ItemPrice[itemID] = newPrice
	net.Start("zcSendCustomPrices")
		net.WriteUInt(1, 32)
		net.WriteString(itemID)
		net.WriteUInt(newPrice, 32)
	net.Broadcast()

	if !file.IsDir("zonecontrol", "DATA") then
		file.CreateDir("zonecontrol")
	end

	file.Write("zonecontrol/itemprices.txt", util.TableToJSON(GAMEMODE.ItemPrice, true))
end
concommand.AddAdmin("rpa_setitemprice", ChangeItemPrice, true)