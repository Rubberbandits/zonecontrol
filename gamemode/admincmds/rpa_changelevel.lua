local function ChangeLevel( ply, args )
	
	if( !args[1] ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end

	if( table.HasValue( GAMEMODE:GetMaps(), args[1] ) ) then

		GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is changing the map to %s in five seconds.", ply:Nick(), map)
		
		GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " changed the map to " .. args[1] .. ".", ply );
		
		timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. args[1] .. "\n" ); end );
		
	else

		netstream.Start( ply, "nAInvalidMap", GAMEMODE:GetMaps() );
		
	end
	
end
concommand.AddAdmin( "rpa_changelevel", ChangeLevel );