

kingston.admin.registerCommand("itemcreate", {
	syntax = "<string item>",
	description = "Spawn an item",
	arguments = {bit.bor(ARGTYPE_NONE, ARGTYPE_STRING)},
	onRun = function(ply, item)
		if item == NULL then
			netstream.Start( ply, "nAListItems", "" )
			return
		end
		
		if GAMEMODE:GetItemByID( item ) then
			GAMEMODE:CreateItem( ply, item )
			
			GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply)
		else
			netstream.Start( ply, "nAListItems", item )
		end
	end,
})