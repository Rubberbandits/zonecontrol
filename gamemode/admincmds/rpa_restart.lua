local function Restart( ply, args )
	
	GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is restarting the server in five seconds.", ply:Nick())
	
	GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " restarted the server.", ply );
	
	timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" ); end );
	
end
concommand.AddAdmin( "rpa_restart", Restart );