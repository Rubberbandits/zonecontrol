kingston.admin.registerCommand("plywake", {
	syntax = "<string target>",
	description = "Wake a knocked out player",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local nick = target:RPName();
		
		target:SetConsciousness( 100 );
		target:WakeUp();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " woke player " .. nick .. ".", ply );
		
		target:Notify(nil, COLOR_NOTIF, "%s woke you up.", ply:Nick())
	end,
})