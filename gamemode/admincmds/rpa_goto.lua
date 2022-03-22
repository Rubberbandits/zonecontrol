

kingston.admin.registerCommand("plygoto", {
	syntax = "<string target>",
	description = "Teleport to a player",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local p = FindGoodTeleportPos( target );
		ply:SetPos( p );
	end,
})