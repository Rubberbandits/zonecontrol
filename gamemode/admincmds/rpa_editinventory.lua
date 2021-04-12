local function EditInventory( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " opened character " .. targ:RPName() .. "'s inventory.", ply );
		
		local inv = {}
		for k,v in next, targ.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars()
			}
		end
		netstream.Start( ply, "nAEditInventory", targ, inv );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_editinventory", EditInventory );

function nARemoveItem( ply, targ, k )
	
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
netstream.Hook( "nARemoveItem", nARemoveItem );local function EditInventory( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " opened character " .. targ:RPName() .. "'s inventory.", ply );
		
		local inv = {}
		for k,v in next, targ.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars()
			}
		end
		netstream.Start( ply, "nAEditInventory", targ, inv );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_editinventory", EditInventory );

function nARemoveItem( ply, targ, k )
	
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