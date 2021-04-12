local function DisableAI( ply, args )
	
	if( !args[1] ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local n = tonumber( args[1] );
	
	if( n != 0 and n != 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	RunConsoleCommand( "ai_disabled", args[1] );
	
end
concommand.AddAdmin( "rpa_aidisabled", DisableAI );