local function SetToolTrust( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 0;
	
	if( trust != 0 and trust != 1 and trust != 2 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetToolTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s tooltrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then

			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed %s's tooltrust.", ply:Nick(), targ:Nick())
			
		else

			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's tooltrust to level %d.", ply:Nick(), targ:Nick(), trust)
			
		end
		
		targ:UpdatePlayerField( "ToolTrust", trust );
		
		if( targ:ToolTrust() == 0 ) then
			
			targ:StripWeapon( "gmod_tool" );
			
		else
			
			targ:Give( "gmod_tool" );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_settooltrust", SetToolTrust );

kingston.admin.registerCommand("plysettooltrust", {
	syntax = "<string target> <number trustLevel>",
	description = "Set a player's tool trust level",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, trustLevel)
		if trust > 2 then
			return false, "Invalid trust level specified"
		end

		target:SetToolTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. target:RPName() .. "'s tooltrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, target };
		
		if( trust == 0 ) then
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed %s's tooltrust.", ply:Nick(), target:Nick())			
		else
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's tooltrust to level %d.", ply:Nick(), target:Nick(), trust)
		end
		
		target:UpdatePlayerField( "ToolTrust", trust );
		
		if( target:ToolTrust() == 0 ) then
			target:StripWeapon( "gmod_tool" );
		else
			target:Give( "gmod_tool" );
		end
	end,
})