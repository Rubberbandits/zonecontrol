local function ChangeBanLength( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No SteamID specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No duration specified.")
		return;
		
	end
	
	local len = tonumber( args[2] );
	
	if( !len ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( len < 0 ) then

		ply:Notify(nil, COLOR_ERROR, "Error: Invalid duration.")
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: No ban found for SteamID given.")
			
		else
			
			local record = GAMEMODE.BanTable[k];
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin change ban length" );
			
			table.insert( GAMEMODE.BanTable, { SteamID = record.SteamID, Length = len, Reason = record.Reason, Date = record.Date } );
			GAMEMODE:AddBan( record.SteamID, len, record.Reason, record.Date );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " changed SteamID " .. args[1] .. "'s ban length to " .. ".", ply );
			
			netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
			
		end
		
	else

		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_changebanlength", ChangeBanLength );