local function SetName( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local name = "";
	
	for i = 2, #args do
		
		name = name .. args[i] .. " ";
		
	end
	
	name = string.Trim( name );
	
	if( targ and targ:IsValid() ) then
		
		if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( name, "#", nil, true ) and !string.find( name, "~", nil, true ) and !string.find( name, "%", nil, true ) ) then
				
				local old = targ:RPName();
				
				targ:SetRPName( string.Trim( name ) );
				targ:UpdateCharacterField( "RPName", name );
				
				GAMEMODE:LogAdmin( "[N] " .. ply:Nick() .. " changed player " .. old .. "'s name to \"" .. name .. "\".", ply );
				
				local rf = { ply, targ };

				GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s changed %s's roleplay name from %s to %s", ply:Nick(), targ:Nick(), old, name)
				
			end
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setname", SetName );