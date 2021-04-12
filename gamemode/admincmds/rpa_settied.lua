local function SetTied( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or ( val != 0 and val != 1 ) ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetTiedUp( val == 1 );
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " tied player " .. targ:RPName() .. ".", ply );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_settied", SetTied );