/*
	nested garbage
	thanks disseminate
*/

local function nBuyItem( ply, id, single )
	local item = GAMEMODE:GetItemByID( id );

	if item and item.License then
		local hasFlag

		for i = 1, #item.License do
			if ply:HasCharFlag(item.License[i]) then
				hasFlag = true
			end
		end

		if !hasFlag then ply:Notify(nil, COLOR_ERROR, "You don't have the connections to buy this.") return end

		local price = hook.Run("GetBuyPrice", ply, id, single)
		if !price or price == 0 then return end

		if single then
			if ply:Money() >= price then
				if ply:InventoryWeight() < ply:InventoryMaxWeight() then
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );

					ply:Notify(nil, COLOR_NOTIF, "You've purchased this single item.")
				else
					ply:Notify(nil, COLOR_ERROR, "You're overencumbered and can't make purchases.")
				end
			else
				ply:Notify(nil, COLOR_ERROR, "You can't afford to buy this.")
			end
		else
			if ply:Money() >= price then
				if ply:InventoryWeight() < ply:InventoryMaxWeight() then
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );

					ply:Notify(nil, COLOR_NOTIF, "You've purchased five of this item.")
				else
					ply:Notify(nil, COLOR_ERROR, "You're overencumbered and can't make purchases.")
				end
			else
				ply:Notify(nil, COLOR_ERROR, "You can't afford to buy this.")
			end
		end
	end
end
netstream.Hook( "nBuyItem", nBuyItem );

util.AddNetworkString("zcSendCustomPrices")

local function zcSendCustomPrices(len, ply)
	if ply.RetrievedItemPrices then return end

	net.Start("zcSendCustomPrices")
		net.WriteUInt(table.Count(GAMEMODE.ItemPrice), 32)
		for id,price in next, GAMEMODE.ItemPrice do
			net.WriteString(id)
			net.WriteUInt(price, 32)
		end
	net.Send(ply)

	ply.RetrievedItemPrices = true
end
net.Receive("zcSendCustomPrices", zcSendCustomPrices)

hook.Add("Initialize", "LoadItemPrices", function()
	local data = file.Read("zonecontrol/itemprices.txt", "DATA")

	GAMEMODE.ItemPrice = data and util.JSONToTable(data) or {}
end)