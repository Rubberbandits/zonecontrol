kingston.admin.registerCommand("musicplaytarget", {
	syntax = "<string musicType> <list[target] targets>",
	description = "Play a random track from several categories for a group of targets",
	arguments = {ARGTYPE_STRING, bit.bor(ARGTYPE_ARRAY, ARGTYPE_TARGET)},
	onRun = function(ply, musicType, targets)
		local song = nil
		
		if musicType == "idle" or musicType == "song_idle" or tonumber(musicType) == 0 then
			song = SONG_IDLE;
		elseif musicType == "alert" or musicType == "song_alert" or tonumber(musicType) == 1 then
			song = SONG_ALERT;
		elseif musicType == "action" or musicType == "song_action" or tonumber(musicType) == 2 then
			song = SONG_ACTION;
		elseif musicType == "stinger" or musicType == "song_stinger" or tonumber(musicType) == 3 then
			song = SONG_STINGER;
		else
			song = musicType;
		end

		if song then
			local ssong = song
			
			if type( song ) == "number" then
				ssong = table.Random( GAMEMODE:GetSongList( song ) );
				GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " targeted music (" .. ssong .. ").", ply );
			else
				GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played targeted music (" .. ssong .. ").", ply );
			end
						
			netstream.Start(targets, "nAPlayMusic", ssong)
		else
			return false, "This is not a valid song or song category"
		end
	end,
})