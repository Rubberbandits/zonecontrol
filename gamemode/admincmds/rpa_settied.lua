kingston.admin.registerCommand("plysettied", {
	syntax = "<string target> <bool tied>",
	description = "Set whether or not a player is tied",
	arguments = {ARGTYPE_TARGET, ARGTYPE_BOOL},
	onRun = function(ply, target, tied)
		target:SetTiedUp(tied)
		GAMEMODE:LogAdmin(Format("[F] %s %s player %s.", ply:Nick(), tied and "tied" or "untied", target:RPName()), ply)
	end,
})