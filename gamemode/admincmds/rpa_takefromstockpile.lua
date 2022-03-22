kingston.admin.registerCommand("stockpiletakeitem", {
	syntax = "<number stockpileID> <number itemID>",
	description = "Take an item from a stockpile",
	arguments = {ARGTYPE_NUMBER, ARGTYPE_NUMBER},
	onRun = function(ply, stockpileID, itemID)
		local stockpile = GAMEMODE.LoadedStockpiles[stockpileID]
	
		if stockpile then
			if !stockpile.Inventory[itemID] then
				return false, "invalid item specified"
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
			
			mysqloo.Query(Format("SELECT * FROM cc_items WHERE id = '%s'", mysqloo.Escape(itemID)), onSuccess)
		else
			return false, "stockpile not found"
		end
	end
})