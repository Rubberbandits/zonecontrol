local function Unban( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No SteamID specified.")
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: No ban found for SteamID given.")
			
		else
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin unban" );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " unbanned SteamID " .. args[1] .. ".", ply );
			
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s unbanned SteamID %s.", ply:Nick(), args[1])
			
			local tab = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( v:IsAdmin() ) then
					
					table.insert( tab, v );
					
				end
				
			end
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: Invalid SteamID specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_unban", Unban );
