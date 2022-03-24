kingston.admin.registerCommand("plyunban", {
	syntax = "<steamID target>",
	description = "Unban a player via their steamID",
	arguments = {ARGTYPE_STEAMID},
	onRun = function(ply, steamID)
		local k = GAMEMODE:LookupBan( steamID );
		
		if( !k ) then
			return false, "no ban found for steamID given"
		end
			
		table.remove( GAMEMODE.BanTable, k );
		GAMEMODE:RemoveBan( steamID, "admin unban" );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " unbanned SteamID " .. steamID .. ".", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s unbanned SteamID %s.", ply:Nick(), steamID)
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:IsAdmin() ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
		
		netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
	end
})