local function SetCharFlag( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local flags = args[2] or "";
	
	if( targ and targ:IsValid() ) then
		
		local old_flags = targ:CharFlags()
		targ:SetCharFlags( flags );
		
		for i=1, #flags do
			local flag = flags[i]
			if !old_flags:find(flag) then
				local new_flag = GAMEMODE.CharFlags[flag]
				if new_flag and new_flag.OnGiven then
					new_flag.OnGiven( targ );
				end
			end
		end
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s character flag to \"" .. flags .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( flags == "" ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed all of %s's flags.", ply:Nick(), targ:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's flags to \"%s\"", ply:Nick(), targ:Nick(), flags)
			
		end
		
		targ:UpdateCharacterField( "CharFlags", flags );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setcharflag", SetCharFlag );