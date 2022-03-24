kingston.admin.registerCommand("charsetmodel", {
	syntax = "<string target> <string modelpath>",
	description = "Set a character's model",
	arguments = {ARGTYPE_TARGET, ARGTYPE_STRING},
	onRun = function(ply, target, model)
		model = string.gsub( string.lower( model ), "\\", "/" );
	
		if( GAMEMODE.TranslateNPCModelTable[model] ) then
			
			model = GAMEMODE.TranslateNPCModelTable[model];
			
		end

		if( target.CharModel == target:GetModel() ) then
			
			target:SetModelCC( model );
			
		end
		
		if( !table.HasValue( GAMEMODE.CitizenModels, model ) ) then
			
			target:SetBody("")
			
		end
		
		target.CharModel = model;
		target:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " changed player " .. target:RPName() .. "'s model to \"" .. model .. "\".", ply );
		
		local rf = { ply, target };
		GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's model to %s.", ply:Nick(), target:Nick(), model)
	end,
})