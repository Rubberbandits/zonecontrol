

kingston.admin.registerCommand("plykill", {
	syntax = "<string target>",
	description = "Kill a player",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local nick = target:RPName();
		
		target:Kill();
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " killed player " .. nick .. ".", ply );
		target:Notify(nil, COLOR_NOTIF, "%s killed you.", ply:Nick())
	end,
})