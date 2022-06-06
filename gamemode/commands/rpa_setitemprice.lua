kingston.admin.registerCommand("itemsetprice", {
	syntax = "<string itemClass> <number price>",
	description = "Set the business menu price of an item",
	arguments = {ARGTYPE_STRING, ARGTYPE_NUMBER},
	onRun = function(ply, itemID, price)
		local metaitem = GAMEMODE:GetItemByID(itemID)
		if !metaitem then
			return false, "invalid item specified"
		end

		GAMEMODE.ItemPrice[itemID] = price
		net.Start("zcSendCustomPrices")
			net.WriteUInt(1, 32)
			net.WriteString(itemID)
			net.WriteUInt(price, 32)
		net.Broadcast()

		if !file.IsDir("zonecontrol", "DATA") then
			file.CreateDir("zonecontrol")
		end

		file.Write("zonecontrol/itemprices.txt", util.TableToJSON(GAMEMODE.ItemPrice, true))
	end,
})