kingston.admin.registerCommand("banchangelength", {
	syntax = "<string target> <number duration>",
	description = "Changes the ban duration of a player. Target is steamID.",
	arguments = {ARGTYPE_STRING, ARGTYPE_NUMBER},
	onRun = function(ply, target, duration)
		if duration < 0 then
			return false, "invalid duration"
		end

		if !string.find( target, "STEAM_") then
			return false, "invalid steamID specified"
		end
			
		local k = GAMEMODE:LookupBan( target );
		
		if !k then
			return false, "ban not found"
		end
		
		local record = GAMEMODE.BanTable[k];
		
		table.remove( GAMEMODE.BanTable, k );
		GAMEMODE:RemoveBan( target, "admin change ban length" );
		
		table.insert( GAMEMODE.BanTable, { SteamID = record.SteamID, Length = len, Reason = record.Reason, Date = record.Date } );
		GAMEMODE:AddBan( record.SteamID, len, record.Reason, record.Date );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " changed SteamID " .. target .. "'s ban length to " .. ".", ply );
		
		netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
	end,
})