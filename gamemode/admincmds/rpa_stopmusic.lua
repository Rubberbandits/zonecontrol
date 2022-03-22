kingston.admin.registerCommand("plyslap", {
	syntax = "<none>",
	description = "Stop music for all players",
	arguments = {},
	onRun = function(ply)
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " stopped any playing music.", ply );
		netstream.Start( nil, "nAStopMusic" );
	end,
})