local function BlowoutTriggerDelayed( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "A blowout is already in progress!")
		return
	end

	ply:Notify(nil, Color(32,255,32), "Delayed blowout sequence starting.")
	kingston.blowout.initiate()
	
	GAMEMODE:LogAdmin( Format("[F] %s started a delayed blowout sequence.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_triggerblowout", BlowoutTriggerDelayed );