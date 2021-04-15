if StormFox2 then
	local function ZeusStrike( ply, args )
		
		if( #args == 0 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
			return;
			
		end
		
		local targ = GAMEMODE:FindPlayer( args[1], ply );
		
		if( targ and targ:IsValid() ) then
			
			StormFox2.Thunder.Strike( targ )
			
			GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " lighnting'd player " .. nick .. ".", ply );

			targ:Notify(nil, COLOR_NOTIF, "%s used zeus lightning on you.", ply:Nick())
			
		else
			
			ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
			
		end
		
	end
	concommand.AddAdmin( "rpa_lightning", ZeusStrike );
end