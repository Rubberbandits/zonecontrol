local function SetModelSelf( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no model specified.")
		return;
		
	end
	local model = args[1] or GAMEMODE.CitizenModels[1];
	
	model = string.gsub( string.lower( model ), "\\", "/" );
	
	if( GAMEMODE.TranslateNPCModelTable[model] ) then
		
		model = GAMEMODE.TranslateNPCModelTable[model];
		
	end
	
	if( ply and ply:IsValid() ) then
		
		if( ply.CharModel == ply:GetModel() ) then
			
			ply:SetModelCC( model );
			
		end
		
		if( !table.HasValue( GAMEMODE.CitizenModels, model ) ) then
			
			ply:SetBody("")
			
		end
		
		ply.CharModel = model;
		ply:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[GM] " .. ply:Nick() .. " changed their model to \"" .. model .. "\".", ply );
		
		ply:Notify(nil, COLOR_NOTIF, "You've set your own model to %s.", model)
		
	end
	
end
concommand.AddGamemaster( "rpg_setmodelself", SetModelSelf );