local function RemoveBadge( ply, args )
	
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
	
	if( !val or !targ:HasBadge( val ) ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetScoreboardBadges( targ:ScoreboardBadges() - val );
		targ:UpdatePlayerField( "ScoreboardBadges", targ:ScoreboardBadges() );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_removebadge", RemoveBadge, true );