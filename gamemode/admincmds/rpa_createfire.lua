local function CreateFire( ply, args )
	
	local num = tonumber( args[1] );
	
	if( !num ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	if( num < 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( num > 60 * 60 * 24 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	local fire = ents.Create( "env_fire" );
	fire:SetPos( tr.HitPos );
	fire:SetKeyValue( "spawnflags", "1" );
	fire:SetKeyValue( "attack", "4" );
	fire:SetKeyValue( "firesize", "128" );
	fire:Spawn();
	fire:Activate();
	fire:Fire( "Enable", "" );
	fire:Fire( "StartFire", "" );
	
	SafeRemoveEntityDelayed( fire, num );
	
end
concommand.AddAdmin( "rpa_createfire", CreateFire );