

kingston.admin.registerCommand("cancelblowout", {
	syntax = "<none>",
	description = "Cancel an active blowout",
	arguments = {},
	onRun = function(ply)
		if GAMEMODE:BlowoutEnabled() < 1 then
			return false, "Blowouts are disabled, use rpa_blowout_enabled 1."
		end
		
		if !kingston.blowout.get_var("Bool", "active_blowout") then 
			return false, "There is no blowout in progress!"
		end

		ply:Notify(nil, Color(32,255,32), "Blowout cancelled.")
		kingston.blowout.cancel()
		
		GAMEMODE:LogAdmin(Format("[F] %s cancelled the ongoing blowout.", ply:Nick()), ply)
	end,
})