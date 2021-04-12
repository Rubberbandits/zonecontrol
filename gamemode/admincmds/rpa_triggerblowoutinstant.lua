local function BlowoutTriggerInstant( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "A blowout is already in progress!")
		return
	end
	
	ply:Notify(nil, Color(32,255,32), "Instant blowout sequence starting.")
	kingston.blowout.initiate(true)
	
	GAMEMODE:LogAdmin( Format("[F] %s started an instant blowout sequence.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_triggerblowoutinstant", BlowoutTriggerInstant );