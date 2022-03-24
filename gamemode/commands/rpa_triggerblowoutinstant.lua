kingston.admin.registerCommand("blowouttriggerinstant", {
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

		ply:Notify(nil, Color(32,255,32), "Instant blowout sequence starting.")
		kingston.blowout.initiate(true)
		
		GAMEMODE:LogAdmin( Format("[F] %s started an instant blowout sequence.", ply:Nick()), ply );
	end
})