kingston.admin.registerCommand("setproptrust", {
	syntax = "<string target> <number trustlevel>",
	description = "Set a player's prop trust level",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, trust)
		if( trust != 0 and trust != 1 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
			return;
			
		end
		
		target:SetPropTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. target:RPName() .. "'s proptrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, target };
		
		if( trust == 0 ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has removed %s's proptrust.", ply:Nick(), target:Nick())
			
		else
		
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has given %s proptrust.", ply:Nick(), target:Nick())
			
		end
		
		target:UpdatePlayerField( "PropTrust", trust );
	end,
})