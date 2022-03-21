

kingston.admin.registerCommand("kick", {
	syntax = "<string target> <string reason>",
	description = "Kick a player from the server",
	arguments = {ARGTYPE_TARGET, ARGTYPE_STRING},
	onRun = function(ply, target, reason)
		local kickString = Format("Kicked by %s (%s)", ply:Nick(), reason)
		local nick = target:RPName() or target:Nick();
		
		target:Kick(kickString)
		GAMEMODE:LogAdmin("[K] " .. ply:Nick() .. " kicked player " .. nick .. " (" .. reason .. ").", ply)
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was kicked by %s. (%s)", nick, ply:Nick(), reason)
	end,
})