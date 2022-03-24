kingston.admin.registerCommand("stopsound", {
	syntax = "<none>",
	description = "Stop music for all players",
	arguments = {},
	onRun = function(ply)
		netstream.Start( nil, "nAStopSound" );
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " stopped all sounds.", ply );
	end,
})