local function GiveAccessToStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local t = args[2] and tonumber( args[2] ) or 0;
	local szJSON;
	
	if( targ and targ:IsValid() ) then
		
		local stockpile = GAMEMODE.LoadedStockpiles[t]
		
		if( stockpile ) then

			if( !table.HasValue( stockpile.Accessors, math.floor( targ:CharID() ) ) ) then

				stockpile.Accessors[#stockpile.Accessors + 1] = targ:CharID();
				szJSON = util.TableToJSON( stockpile.Accessors );
				
				local function onSuccess()
				
					GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " gave access to " .. targ:RPName() .. " for stockpile \"" .. t .. "\".", ply );
				
				end
				mysqloo.Query( Format( "UPDATE cc_stockpiles SET Accessors = '%s' WHERE id = '%s'", szJSON, t ), onSuccess );
			
			end
			
		else
		
			ply:Notify(nil, COLOR_ERROR, "Error: stockpile not found.")
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end

end
concommand.AddAdmin( "rpa_giveaccesstostockpile", GiveAccessToStockpile );