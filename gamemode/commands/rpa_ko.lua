

kingston.admin.registerCommand("plyknockout", {
	syntax = "<string target>",
	description = "Knockout a player",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local nick = target:RPName();
		
		target:SetConsciousness( 0 );
		target:PassOut();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " KO'd player " .. nick .. ".", ply );
		
		target:Notify(nil, COLOR_NOTIF, "%s knocked you out.", ply:Nick())
	end,
})