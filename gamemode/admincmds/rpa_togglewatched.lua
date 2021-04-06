local function SetWatched( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
	
		targ:SetWatched(!targ:Watched())
		targ:UpdatePlayerField( "Watched", targ:Watched() and "1" or "0" )
		ply:Notify(nil, COLOR_NOTIF, targ:Watched() and "%s is now being watched." or "%s is no longer being watched.", targ:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_togglewatched", SetWatched );