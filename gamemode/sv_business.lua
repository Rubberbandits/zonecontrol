function nBuyBusinessLicense( ply, t )
	
	if( GAMEMODE.BusinessLicenses[t] and GAMEMODE.BusinessLicenses[t][2] and bit.band( ply:BusinessLicenses(), t ) != t ) then
		
		if( ply:Money() >= GAMEMODE.BusinessLicenses[t][2] ) then
			
			ply:AddMoney( -1 * GAMEMODE.BusinessLicenses[t][2] );
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
			ply:SetBusinessLicenses( ply:BusinessLicenses() + t );
			ply:UpdateCharacterField( "BusinessLicenses", ply:BusinessLicenses() );
			
			netstream.Start( ply, "nPopulateBusiness" );
			
		end
		
	end
	
end
netstream.Hook( "nBuyBusinessLicense", nBuyBusinessLicense );

function nBuyItem( ply, id, single )
	
	local item = GAMEMODE:GetItemByID( id );
	local lic = ply:BusinessLicenses();
	
	if( ply:HasCharFlag( "X" ) ) then lic = lic + LICENSE_BLACK end
	
	if( item and bit.band( lic, item.License or -1 ) == item.License ) then

		local price = hook.Run("GetBuyPrice", ply, id, single)

		if !price or price == 0 then return end

		if( single ) then
			
			if( ply:Money() >= price ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );
					
				end
				
			end
			
		else
			
			if( ply:Money() >= price ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					
				end
				
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