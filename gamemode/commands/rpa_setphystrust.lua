kingston.admin.registerCommand("plysetphystrust", {
	syntax = "<string target> <number trustlevel>",
	description = "Set a player's physgun trust level",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, trust)
		if( trust != 0 and trust != 1 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
			return;
			
		end
		
		target:SetPhysTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. target:RPName() .. "'s phystrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, target };
		
		if( trust == 0 ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has removed %s's phystrust.", ply:Nick(), target:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has given %s phystrust.", ply:Nick(), target:Nick())
			
		end
		
		target:UpdatePlayerField( "PhysTrust", trust );
		
		if( target:PhysTrust() == 0 ) then
			
			target:StripWeapon( "weapon_physgun" );
			
		else
			
			target:Give( "weapon_physgun" );
			
		end
	end,
})