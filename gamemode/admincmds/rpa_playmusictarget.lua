local function PlayMusicTarget( ply, args )
	
	if( #args < 2 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	local arg = string.lower( args[1] );
	local song = nil;
	
	if( arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 ) then
		
		song = SONG_IDLE;
		arg = "idle";
		
	elseif( arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 ) then
		
		song = SONG_ALERT;
		arg = "alert";
		
	elseif( arg == "action" or arg == "song_action" or tonumber( arg ) == 2 ) then
		
		song = SONG_ACTION;
		arg = "action";
		
	elseif( arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 ) then
		
		song = SONG_STINGER;
		arg = "stinger";
		
	else
		
		song = arg;
		
	end
	
	if( song ) then
		
		local ssong = song;
		
		if( type( song ) == "number" ) then
			
			ssong = table.Random( GAMEMODE:GetSongList( song ) );
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " targeted music (" .. ssong .. ").", ply );
			
		else
			
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played targeted music (" .. ssong .. ").", ply );
			
		end
		
		local plys = { };
		
		for i = 2, #args do
			
			local targ = GAMEMODE:FindPlayer( args[i], ply );
			
			if( targ and targ:IsValid() ) then
				
				table.insert( plys, targ );
				
			else

				ply:Notify(nil, COLOR_ERROR, "Error: No target found (\"&s\"). Skipping.", args[i])
				
			end
			
		end

		netstream.Start( plys, "nAPlayMusic", ssong );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_playmusictarget", PlayMusicTarget );