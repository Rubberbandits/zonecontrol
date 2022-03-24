local function nARemoveItem( ply, targ, k )
	
	if( !ply:IsAdmin() ) then
		
		return;
		
	end
	
	local item = targ.Inventory[k]
	
	if item then
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " took character " .. targ:RPName() .. "'s item \"" .. targ.Inventory[k]:GetName() .. "\".", ply );
		GAMEMODE:LogItems( "[R] " .. targ:VisibleRPName() .. "'s item " .. targ.Inventory[k]:GetName() .. " was taken by " .. ply:Nick() .. ".", ply );
		
		targ:Notify(nil, COLOR_NOTIF, "%s has taken your %s (%s)!", ply:Nick(), item:GetName(), item:GetClass())
		
		if item:GetVar("Equipped", false) then
			item:CallFunction("Unequip", true)
		end
		
		netstream.Start(targ, "RemoveItem", k)
		
		item.owner = ply;
		item:SetCharID( ply:CharID() )
		item:UpdateSave();
		item:TransmitToOwner();
		targ.Inventory[k] = nil
		ply.Inventory[k] = item
		
		hook.Run("ItemDropped", targ, item)
		hook.Run("ItemPickedUp", ply, item)
		
		local inv = {}
		for k,v in next, targ.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars(),
			}
		end
		netstream.Start( ply, "nAUpdateInventory", targ, inv );
	end
	
end
netstream.Hook( "nARemoveItem", nARemoveItem );

kingston.admin.registerCommand("chareditinventory", {
	syntax = "<string target>",
	description = "Edit a player's inventory",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " opened character " .. target:RPName() .. "'s inventory.", ply)
		
		local inv = {}
		for k,v in next, target.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars()
			}
		end

		netstream.Start(ply, "nAEditInventory", target, inv)
	end,
})