local function SetPhysTrust( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 1;
	
	if( trust != 0 and trust != 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: this target is an admin.")
			return;
			
		end
		
		targ:SetPhysTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s phystrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has removed %s's phystrust.", ply:Nick(), targ:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has given %s phystrust.", ply:Nick(), targ:Nick())
			
		end
		
		targ:UpdatePlayerField( "PhysTrust", trust );
		
		if( targ:PhysTrust() == 0 ) then
			
			targ:StripWeapon( "weapon_physgun" );
			
		else
			
			targ:Give( "weapon_physgun" );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setphystrust", SetPhysTrust );