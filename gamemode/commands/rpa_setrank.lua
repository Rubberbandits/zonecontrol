kingston.admin.registerCommand("plysetrank", {
	syntax = "<string target> <string rank>",
	description = "Set a player's rank",
	arguments = {bit.bor(ARGTYPE_TARGET, ARGTYPE_STEAMID), ARGTYPE_STRING},
	onRun = function(ply, target, rank)
		// add offline steamID support
		target:SetUserGroup(rank)
		target:UpdatePlayerField("Rank", rank)
		
		GAMEMODE:Notify({ply, target}, nil, COLOR_NOTIF, "%s set %s's rank to %s.", ply:Nick(), target:Nick(), rank)
	end,
})