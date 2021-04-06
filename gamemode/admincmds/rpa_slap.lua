local function Slap( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetVelocity( Vector( math.random( -400, 400 ), math.random( -400, 400 ), math.random( 400, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[P] " .. ply:Nick() .. " slapped player " .. nick .. ".", ply );

		targ:Notify(nil, COLOR_NOTIF, "%s slapped you.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_slap", Slap );