local function Kick( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	local reason = "Kicked by " .. ply:Nick();
	
	if( args[2] ) then
		
		reason = "Kicked by " .. ply:Nick() .. " (" .. args[2] .. ")";
		
	end
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName() or targ:Nick();
		
		targ:Kick( reason );

		GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " kicked player " .. nick .. " (" .. (args[2] or "No reason specified.") .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was kicked by %s. (%s)", nick, ply:Nick(), args[2] or "No reason specified.")
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_kick", Kick );