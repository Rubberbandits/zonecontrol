local function Ban( ply, args )

	if( !IsValid( ply ) ) then
	
		if( #args == 0 ) then
			
			Msg( "nANoTargetSpecified\n" );
			return;
			
		end
		
		if( #args == 1 ) then
			
			Msg( "nANoDurationSpecified\n" );
			return;
			
		end
		
		if( tonumber( args[2] ) < 0 ) then
			
			Msg( "nANegativeDuration\n" );
			return;
			
		end
	
	else
	
		if( #args == 0 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
			return;
			
		end
		
		if( #args == 1 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no duration specified.")
			return;
			
		end
		
		if( tonumber( args[2] ) < 0 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: Invalid duration.")
			return;
			
		end
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local reason;
	
	if( !IsValid( ply ) ) then
	
		reason = "Banned for " .. args[2] .. " minutes by console.";
		
		if( args[3] ) then
		
			reason = "Banned for " .. args[2] .. " minutes by console. (" .. args[3] .. ")";
			
			if( args[2] == "0" ) then
				
				reason = "Permabanned by console. (" .. args[3] .. ")";
				
			end
			
		end
		
	else
	
		reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick();
		
		if( args[3] ) then
			
			reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick() .. " (" .. args[3] .. ")";
			
			if( args[2] == "0" ) then
				
				reason = "Permabanned by " .. ply:Nick() .. " (" .. args[3] .. ")";
				
			end
			
		end
		
	end
	
	local reasonin = args[3] or "No reason specified.";
	
	if( !IsValid( ply ) ) then
	
		if( targ and targ:IsValid() ) then
			
			local nick = targ:RPName();
			
			if( !targ:IsBot() ) then
				
				if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
				
				table.insert( GAMEMODE.BanTable, { SteamID = targ:SteamID(), Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
				GAMEMODE:AddBan( targ:SteamID(), args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
				
			end
			
			targ:Kick( reason );
			
			GAMEMODE:LogConsole( "[B] Console banned player " .. nick .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", true );
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by Console for %s minutes. (%s)", nick, args[2], args[3] or "No reason specified.")
			
		elseif( string.find( args[1], "STEAM_" ) ) then
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			table.insert( GAMEMODE.BanTable, { SteamID = args[1], Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
			GAMEMODE:AddBan( args[1], args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
			
			GAMEMODE:LogConsole( "[B] Console banned SteamID " .. args[1] .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", true );
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by Console for %s minutes. (%s)", args[1], args[2], args[3] or "No reason specified.")
			
		else
			
			Msg( "No Target Found\n" );
			
		end
		
		return;
	
	end
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		if( !targ:IsBot() ) then
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			table.insert( GAMEMODE.BanTable, { SteamID = targ:SteamID(), Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
			GAMEMODE:AddBan( targ:SteamID(), args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
			
		end
		
		targ:Kick( reason );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned player " .. nick .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %s minutes. (%s)", nick, ply:Nick(), args[2], args[3] or "No reason specified.")
		
	elseif( string.find( args[1], "STEAM_" ) ) then
		
		if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
		
		table.insert( GAMEMODE.BanTable, { SteamID = args[1], Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
		GAMEMODE:AddBan( args[1], args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned SteamID " .. args[1] .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %s minutes. (%s)", args[1], ply:Nick(), args[2], args[3] or "No reason specified.")
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_ban", Ban );