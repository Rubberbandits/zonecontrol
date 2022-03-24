kingston.admin.registerCommand("plysend", {
	syntax = "<string target> <string destination>",
	description = "Teleport a target player to a destination player",
	arguments = {ARGTYPE_TARGET, ARGTYPE_TARGET},
	onRun = function(ply, target, destination)
		local p = FindGoodTeleportPos(destination)
		target:SetPos(p)
	end,
})