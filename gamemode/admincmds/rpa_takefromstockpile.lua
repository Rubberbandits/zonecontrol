local function TakeFromStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local id = args[1] and tonumber(args[1]);
	local item_id = args[2] and tonumber( args[2] );
	local stockpile = GAMEMODE.LoadedStockpiles[id]
	
	if stockpile then
		if !stockpile.Inventory[item_id] then
			ply:Notify(nil, Color(200,0,0), "Error: Invalid item specified.")
			return
		end
		
		local function onSuccess( ret )
		
			for k,v in next, ret do
			
				if !GAMEMODE:GetItemByID(v.ItemClass) then continue end
			
				local object = item( ply, v.ItemClass, v.id, util.JSONToTable(v.Vars) );
				object:TransmitToOwner();
				object:UpdateSave();
				stockpile.Inventory[item] = nil
				
				GAMEMODE:LogAdmin( Format("[F] %s removed %s from stash \"%s\".", ply:Nick(), object:GetName(), stockpile.Name), ply );
			
			end
		end
		mysqloo.Query(Format("SELECT * FROM cc_items WHERE id = '%s'", mysqloo.Escape(args[2])), onSuccess)
		
	else
		
		ply:Notify(nil, Color(200,0,0), "Error: No stockpile found")
		
	end

end
concommand.AddAdmin( "rpa_takefromstockpile", TakeFromStockpile );