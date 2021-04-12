local function StopSound( ply, args )
	
	netstream.Start( nil, "nAStopSound" );
	
	GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " stopped all sounds.", ply );
	
end
concommand.AddAdmin( "rpa_stopsound", StopSound );