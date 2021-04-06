local function StopMusic( ply, args )
	
	GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " stopped any playing music.", ply );
	netstream.Start( nil, "nAStopMusic" );
	
end
concommand.AddAdmin( "rpa_stopmusic", StopMusic );