kingston.admin.registerCommand("blowouttrigger", {
	syntax = "<none>",
	description = "Trigger a delayed blowout",
	arguments = {},
	onRun = function(ply, target)
		if GAMEMODE:BlowoutEnabled() < 1 then
			return false, "Blowouts are disabled, use rpa_blowout_enabled 1"
		end
		
		if kingston.blowout.get_var("Bool", "active_blowout") then 
			return false, "A blowout is already in progress!"
		end

		ply:Notify(nil, Color(32,255,32), "Delayed blowout sequence starting.")
		kingston.blowout.initiate()
		
		GAMEMODE:LogAdmin( Format("[F] %s started a delayed blowout sequence.", ply:Nick()), ply );
	end
})