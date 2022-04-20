kingston.admin.registerCommand("plysettooltrust", {
	syntax = "<string target> <number trustLevel>",
	description = "Set a player's tool trust level",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, trust)
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