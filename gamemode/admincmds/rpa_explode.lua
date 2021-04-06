local function Explode( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		local explo = ents.Create( "env_explosion" );
		explo:SetOwner( ply );
		explo:SetPos( targ:GetPos() );
		explo:SetKeyValue( "iMagnitude", 1000 );
		explo:SetKeyValue( "iRadiusOverride", 32 );
		explo:Spawn();
		explo:Activate();
		explo:Fire( "Explode" );
		
		targ:SetVelocity( Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( 300, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " exploded player " .. nick .. ".", ply );

		targ:Notify(nil, COLOR_NOTIF, "%s exploded you.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_explode", Explode );