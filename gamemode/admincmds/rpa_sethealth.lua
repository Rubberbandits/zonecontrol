local function SetHealth(ply, args)
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local health = tonumber(args[2])
	
	if !health then
		ply:Notify(nil, COLOR_ERROR, "Error: invalid health value specified.")
		return
	end
	
	if( targ and targ:IsValid() ) then
	
		targ:SetHealth(health)
		ply:Notify(nil, COLOR_NOTIF, "You've set %s's health to %d.", targ:RPName(), health)
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
end
concommand.AddAdmin("rpa_sethealth", SetHealth)