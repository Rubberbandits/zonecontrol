local function BlowoutCancel( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if !kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "There is no blowout in progress!")
		return
	end

	ply:Notify(nil, Color(32,255,32), "Blowout cancelled.")
	kingston.blowout.cancel()
	
	GAMEMODE:LogAdmin( Format("[F] %s cancelled the ongoing blowout.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_cancelblowout", BlowoutCancel );