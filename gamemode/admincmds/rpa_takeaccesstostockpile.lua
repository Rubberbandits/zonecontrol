local function TakeAccessToStockpile( ply, args )

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

			if( table.HasValue( stockpile.Accessors, math.floor( targ:CharID() ) ) ) then

				for k,v in next, stockpile.Accessors do
				
					if( v == math.floor( targ:CharID() ) ) then
					
						table.remove( stockpile.Accessors, k );
						break;
						
					end
					
				end
				szJSON = util.TableToJSON( stockpile.Accessors );
				
				local function onSuccess()
				
					GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " took access from " .. targ:RPName() .. " for stockpile \"" .. t .. "\".", ply );
				
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
concommand.AddAdmin( "rpa_takeaccesstostockpile", TakeAccessToStockpile );