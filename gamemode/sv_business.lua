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

		if( single ) then
			
			if( ply:Money() >= item.BulkPrice / 5 + ( ( item.BulkPrice / 5 ) / GAMEMODE.SellPercentage ) ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * math.Round(( item.BulkPrice / 5 + ( ( item.BulkPrice / 5 ) / GAMEMODE.SellPercentage ) )) );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );
					
				end
				
			end
			
		else
			
			if( ply:Money() >= item.BulkPrice ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * math.Round(item.BulkPrice) );
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