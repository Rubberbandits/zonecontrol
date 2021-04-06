local function KO( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetConsciousness( 0 );
		targ:PassOut();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " KO'd player " .. nick .. ".", ply );
		
		targ:Notify(nil, COLOR_NOTIF, "%s knocked you out.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_ko", KO );