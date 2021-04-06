local function SetCharModel( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local model = args[2] or GAMEMODE.CitizenModels[1];
	
	model = string.gsub( string.lower( model ), "\\", "/" );
	
	if( GAMEMODE.TranslateNPCModelTable[model] ) then
		
		model = GAMEMODE.TranslateNPCModelTable[model];
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ.CharModel == targ:GetModel() ) then
			
			targ:SetModelCC( model );
			
		end
		
		if( !table.HasValue( GAMEMODE.CitizenModels, model ) ) then
			
			targ:SetBody("")
			
		end
		
		targ.CharModel = model;
		targ:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s model to \"" .. model .. "\".", ply );
		
		local rf = { ply, targ };
		GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's model to %s.", ply:Nick(), targ:Nick(), model)
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setcharmodel", SetCharModel );