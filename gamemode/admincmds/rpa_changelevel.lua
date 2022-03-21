

kingston.admin.registerCommand("changelevel", {
	syntax = "<string mapname>",
	description = "Change the current level of the server",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, mapname)
		if table.HasValue(GAMEMODE:GetMaps(), mapname) then
			GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is changing the map to %s in five seconds.", ply:Nick(), mapname)
			GAMEMODE:LogAdmin("[R] " .. ply:Nick() .. " changed the map to " .. mapname .. ".", ply)
			
			timer.Simple(5, function() game.ConsoleCommand( "changelevel " .. mapname .. "\n" ) end)
		else
			netstream.Start(ply, "nAInvalidMap", GAMEMODE:GetMaps())
		end
	end,
})