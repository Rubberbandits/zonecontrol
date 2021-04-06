local function GiveMoney( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local amt = 0;
	
	if( args[2] ) then
		
		amt = tonumber( args[2] );
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:AddMoney( amt );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		targ:Notify(nil, COLOR_NOTIF, "%s gave you %d rubles.", ply:Nick(), amt)
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " gave " .. targ:RPName() .. " " .. tostring( amt ) .. " rubles.", ply );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_givemoney", GiveMoney );