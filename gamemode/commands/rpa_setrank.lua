kingston.admin.registerCommand("plysetrank", {
	syntax = "<string target> <string rank>",
	description = "Set a player's rank",
	arguments = {bit.bor(ARGTYPE_TARGET, ARGTYPE_STEAMID), bit.bor(ARGTYPE_STRING, ARGTYPE_NONE)},
	onRun = function(ply, target, rank)
		rank = rank != NULL and rank or "user"

		// add offline steamID support
		target:SetUserGroup(rank)
		target:UpdatePlayerField("Rank", rank)
		
		GAMEMODE:Notify({ply, target}, nil, COLOR_NOTIF, "%s set %s's rank to %s.", ply:Nick(), target:Nick(), rank)
	end,
})