

kingston.admin.registerCommand("playmusic", {
	syntax = "<string songtype>",
	description = "Play a random track from a category of ambient tracks",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, arg)
		local song = nil;
		
		if arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 then
			
			song = SONG_IDLE;
			arg = "idle";
			
		elseif arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 then
			
			song = SONG_ALERT;
			arg = "alert";
			
		elseif arg == "action" or arg == "song_action" or tonumber( arg ) == 2 then
			
			song = SONG_ACTION;
			arg = "action";
			
		elseif arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 then
			
			song = SONG_STINGER;
			arg = "stinger";
			
		else
			
			song = arg;
			
		end
		
		if( song ) then
			local ssong = song;
			
			if( type( song ) == "number" ) then
				
				ssong = table.Random( GAMEMODE:GetSongList( song ) );
				GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " music (" .. ssong .. ").", ply );
				
			else
				
				GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played music (" .. ssong .. ").", ply );
				
			end
			
			netstream.Start( nil, "nAPlayMusic", ssong );
		end
	end,
})