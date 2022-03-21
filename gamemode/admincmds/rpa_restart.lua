kingston.admin.registerCommand("restart", {
	syntax = "<none>",
	description = "Restart the server via changelevel. Only refreshes Lua state",
	arguments = {},
	onRun = function(ply)
		GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is restarting the server in five seconds.", ply:Nick())
		
		GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " restarted the server.", ply );
		
		timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" ); end );
	end,
})