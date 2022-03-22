

kingston.admin.registerCommand("plybring", {
	ignoreRank = true,
	syntax = "<string target>",
	description = "Teleport a player to your location.",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local p = FindGoodTeleportPos(ply);
		target:SetPos(p);
	end,
})