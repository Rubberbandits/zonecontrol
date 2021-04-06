
local function Send( ply, args )

	if( #args == 0 ) then
	
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
	
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local destination = GAMEMODE:FindPlayer( args[2], ply );
	
	if( targ and targ:IsValid() ) then
	
		if( destination and destination:IsValid() ) then
		
			local p = FindGoodTeleportPos( destination );
			targ:SetPos( p );
		
		else
		
			ply:Notify(nil, COLOR_ERROR, "Error: second target not found.")
		
		end
	
	else
	
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
	
	end

end
concommand.AddAdmin( "rpa_send", Send )