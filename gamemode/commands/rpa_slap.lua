kingston.admin.registerCommand("plyslap", {
	syntax = "<string target>",
	description = "Slap a player",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target, tied)
		local nick = target:RPName();
		
		target:SetVelocity( Vector( math.random( -400, 400 ), math.random( -400, 400 ), math.random( 400, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[P] " .. ply:Nick() .. " slapped player " .. nick .. ".", ply );

		target:Notify(nil, COLOR_NOTIF, "%s slapped you.", ply:Nick())
	end,
})