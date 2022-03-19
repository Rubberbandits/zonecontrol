local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

kingston.admin.registerCommand("plyban", {
	syntax = "<string target> <number duration> <string reason>",
	description = "Bans a player from the server. Target can be either player name or steamID.",
	arguments = {ARGTYPE_STRING, ARGTYPE_NUMBER, ARGTYPE_STRING},
	onRun = function(ply, target, duration, reason)
		local kickString = Format(
			"Banned %s by %s (%s)", 
			duration == 0 and "permanently" or Format("for %d minutes", duration),
			IsValid(ply) and ply:Nick() or "console",
			reason
		)

		local targ = GAMEMODE:FindPlayer(target)
		
		if targ and targ:IsValid() then
			local nick = targ:RPName()
			
			if( !targ:IsBot() ) then
				if !GAMEMODE.BanTable then GAMEMODE.BanTable = {} end
				
				table.insert(GAMEMODE.BanTable, {SteamID = targ:SteamID(), Length = duration, Reason = reason, Date = os.date( "!%m/%d/%y %H:%M:%S" )})
				GAMEMODE:AddBan(targ:SteamID(), duration, reason, os.date("!%m/%d/%y %H:%M:%S"))
			end
			
			targ:Kick(kickString)
			
			GAMEMODE:LogAdmin(Format("[B] %s banned player %s for %d minutes (%s)", ply:Nick(), nick, duration, reason), ply)
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %d minutes. (%s)", nick, ply:Nick(), duration, reason)
		elseif string.find( target, "STEAM_") then
			if !GAMEMODE.BanTable then GAMEMODE.BanTable = {} end
			
			table.insert(GAMEMODE.BanTable, {SteamID = target, Length = duration, Reason = reason, Date = os.date("!%m/%d/%y %H:%M:%S")})
			GAMEMODE:AddBan(target, duration, reason, os.date( "!%m/%d/%y %H:%M:%S" ))

			GAMEMODE:LogAdmin(Format("[B] %s banned SteamID %s for %d minutes (%s)", target, nick, duration, reason), ply)
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "SteamID %s was banned by %s for %d minutes. (%s)", target, ply:Nick(), duration, reason)
		else
			return false, "target not found."
		end
	end,
})