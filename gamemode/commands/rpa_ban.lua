kingston.admin.registerCommand("plyban", {
	syntax = "<string target> <number duration> <string reason>",
	description = "Bans a player from the server. target can be either player name or steamID.",
	arguments = {bit.bor(ARGTYPE_TARGET, ARGTYPE_STEAMID), ARGTYPE_NUMBER, ARGTYPE_STRING},
	onRun = function(ply, target, duration, reason)
		local kickString = Format(
			"Banned %s by %s (%s)", 
			duration == 0 and "permanently" or Format("for %d minutes", duration),
			IsValid(ply) and ply:Nick() or "console",
			reason
		)

		local subject = isentity(target) and target:SteamID() or target
		local nick = isentity(target) and target:RPName() or Format("SteamID %s", target)

		table.insert(GAMEMODE.BanTable, {SteamID = subject, Length = duration, Reason = reason, Date = os.date( "!%m/%d/%y %H:%M:%S" )})
		GAMEMODE:AddBan(subject, duration, reason, os.date("!%m/%d/%y %H:%M:%S"))

		if isentity(target) then
			target:Kick(kickString)
		end

		GAMEMODE:LogAdmin(Format("[B] %s banned player %s for %d minutes (%s)", ply:Nick(), nick, duration, reason), ply)
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %d minutes. (%s)", nick, ply:Nick(), duration, reason)
	end,
})