hook.Add("CanPickup", "CC_HiddenCheck", function(ply, item_object, item_ent)
	if( item_ent:GetNoDraw() and !ply:IsAdmin() ) then
		return false
	end
	
	return true
end)

netstream.Hook( "ItemCallFunction", function( ply, s_nID, s_szKey )

	local s_Item = ply:FindItemByID( s_nID );
	if( s_Item ) then

		s_Item:CallFunction( s_szKey );
		
	end


end );

netstream.Hook( "ItemCallDynamicFunction", function( ply, s_nID, s_nFuncKey )

	local s_Item = ply:FindItemByID( s_nID );
	
	if( s_Item and s_Item.DynamicFunctions ) then
	
		local struct = s_Item:DynamicFunctions()[s_nFuncKey];
	
		if( struct.CanRun( s_Item ) ) then
	
			struct.OnUse( s_Item );
			
		end
		
	end
	
end );

netstream.Hook( "ItemDrop", function( ply, s_nID )

	local s_Item = ply:FindItemByID( s_nID );
	
	if( s_Item ) then

		s_Item:DropItem();
		
	end

end );

function GM:DropItem( s_Item )

	if( s_Item ) then

		local ply = s_Item:Owner()
		local item_ent = self:CreateItemEntity( s_Item, s_Item:Owner():EyePos() + s_Item:Owner():GetAimVector() * 50, Angle() );
		hook.Run( "ItemDropped", ply, s_Item );
		return item_ent
		
	end

end

-- when a previous item object does not exist.
function GM:CreateNewItemEntity( szClass, pos, ang )

	local ent = ents.Create( "cc_item" );
	ent:SetItemClass( szClass );
	ent:SetPos( pos );
	ent:SetAngles( ang );
	ent:Spawn();
	ent:Activate();
	
	hook.Run( "OnNewItemEntityCreated", ent );
	
	return ent;
	
end

GM.OnAdminCreatedItemEntity = GM.OnAdminCreatedItem;

function GM:OnNewItemEntityCreated( entity )

end

-- when a previous item object exists, e.g. dropping an item
function GM:CreateItemEntity( ItemObj, pos, ang )

	local ent = ents.Create( "cc_item" );
	ent:SetVarString( util.TableToJSON( ItemObj:GetVars() ) );
	ItemObj:Owner().Inventory[ItemObj:GetID()] = nil;
	ItemObj.owner = ent;
	ItemObj:SetCharID( 0 );
	ent.ItemObj = ItemObj;
	ItemObj:UpdateSave();
	ent:SetItemClass( ItemObj:GetClass() );
	ent:SetPos( pos );
	ent:SetAngles( ang );
	ent:Spawn();
	ent:Activate();
	
	return ent;

end

function GM:UpdateEncumberance(ply, item)
	if ply.LastWeight then
		if ply.LastWeight <= ply:InventoryMaxWeight() then
			local weight = ply:InventoryWeight()
			if isstring(item) then
				local metaitem = GAMEMODE:GetItemByID(item)
				
				if metaitem and metaitem.PickupSound then
					ply:EmitSound(metaitem.PickupSound, 75, 100, 1, CHAN_ITEM)
				end

				if weight + metaitem.Weight > ply:InventoryMaxWeight() then
					ply:Notify(nil, Color(255,100,0), "You're now over-encumbered.")
					ply:SetRunSpeed(ply:GetWalkSpeed())
				end
				
				if weight > (ply.LastMaxWeight or 0) then
					local walk, run, jump, crouch = ply:GetSpeeds()
					ply:SetRunSpeed(run)
					ply:Notify(nil, Color(255,100,0), "You're no longer over-encumbered.")
				end
				
				ply.LastWeight = weight + metaitem.Weight
			else
				if item and item.PickupSound then
					ply:EmitSound(item.PickupSound, 75, 100, 1, CHAN_ITEM)
				end
				
				if weight > ply:InventoryMaxWeight() then
					ply:Notify(nil, Color(255,100,0), "You're now over-encumbered.")
					ply:SetRunSpeed(ply:GetWalkSpeed())
				end
				
				if weight > (ply.LastMaxWeight or 0) and (ply.LastMaxWeight or 0) < ply:InventoryMaxWeight() then
					local walk, run, jump, crouch = ply:GetSpeeds()
					ply:SetRunSpeed(run)
					ply:Notify(nil, Color(255,100,0), "You're no longer over-encumbered.")
				end
				
				kingston.log.write("items", "[%s (%s)(%s)] picked up item %s [ID: %d]", ply:RPName(), ply:Nick(), ply:SteamID(), item:GetName(), item:GetID())
				
				ply.LastWeight = ply:InventoryWeight()
			end
		end
		
		if ply.LastWeight and ply.LastWeight >= ply:InventoryMaxWeight() then
			if ply:InventoryWeight() <= ply:InventoryMaxWeight() then
				local walk, run, jump, crouch = ply:GetSpeeds();
				ply:SetRunSpeed(run)
				ply:Notify(nil, Color(255,100,0), "You're no longer over-encumbered.")
			end
			
			if ply:InventoryWeight() > ply:InventoryMaxWeight() then
				ply:Notify(nil, Color(255,100,0), "You're now over-encumbered.")
				ply:SetRunSpeed(ply:GetWalkSpeed())
			end
		end
	end
	
	ply.LastWeight = ply:InventoryWeight()
	ply.LastMaxWeight = ply:InventoryMaxWeight()
end

function GM:ItemPickedUp( ply, item )
	if !isstring(item) then
		if item:GetClass() == "pda" then
			if item:GetVar("Primary",false) then
				item:SetVar("Primary", false, nil, true)
			end
		end
	end
	
	self:UpdateEncumberance(ply, item)
end

function GM:ItemDropped( ply, item )
	-- when this is called, the entity hasnt actually
	-- been created yet. 

	self:UpdateEncumberance(ply, item)
end

function GM:MoneyGiven(giver, receiver, amount)
	local giver_msg = Format("You've given %d RU to %s", amount, receiver:RPName())
	giver:PDANotify("Message", giver_msg, 5, 7)
	
	local receiver_msg = Format("You've received %d RU from %s", amount, giver:RPName())
	receiver:PDANotify("Message", receiver_msg, 5, 8)
	
	kingston.log.write("items", "Player %s (%s) has given %s (%s) %d rubles.", giver:RPName(), giver:Nick(), receiver:RPName(), receiver:Nick(), amount)
end

netstream.Hook( "RetrieveDummyItems", function( ply )

	for k,v in next, GAMEMODE.g_ItemTable do
	
		if( v.IsTransmitted ) then
		
			netstream.Start( ply, "ReceiveDummyItem", v:GetID(), v:GetClass(), v:GetVars(), v:Owner(), v.CharID );
		
		end
	
	end

end );

netstream.Hook("RequestItemUpgrade", function(ply, nItemID, szUpgrade)
	local ItemObj = GAMEMODE.g_ItemTable[nItemID]
	local Upgrade = GAMEMODE.Upgrades[szUpgrade]
	if ItemObj and Upgrade then
		if Upgrade.CanUpgrade(Upgrade, ItemObj) then
			Upgrade.OnUpgrade(Upgrade, ItemObj)
		end
	end
end)

hook.Add("PlayerDisconnected", "STALKER.ItemDisconnected", function(ply)
	for k,v in next, GAMEMODE.g_ItemTable do
		if v:Owner() == ply and v.OnDisconnected then
			v:OnDisconnected()
		end
	end
end)

netstream.Hook("ChangeItemData", function(ply, id, data)
	if !ply:IsAdmin() then return end

	local item = GAMEMODE.g_ItemTable[id]
	if !item then return end
	if !data then return end
	
	-- need to do minmax checking and auth
	
	for k,v in next, data do
		if k == "PrivateVars" then continue end
		
		item:SetVar(k, v, nil, true)
	end
end)

netstream.Hook("StackItem", function(ply, item_id, to_stack_id)
	local item = ply.Inventory[item_id]
	local to_stack = ply.Inventory[to_stack_id]
	
	if item and to_stack then
		if item:CanStack(to_stack) then
			item:OnStack(to_stack)
		end
	end
end)

netstream.Hook("SplitStack", function(ply, item_id, amt, x, y)
	local item = ply.Inventory[item_id]
	if item and item:CanSplitStack(amt) then
		if x and y then
			if ply:IsInventorySlotOccupiedItem(x, y, item.W, item.H) then return end
		end

		item:SplitStack(amt, x, y)
	end
end)

netstream.Hook("ItemSetPos", function(ply, item_id, x, y)
	local item = ply.Inventory[item_id]
	if !item then return end
	if x > GAMEMODE.InventoryWidth then return end
	if y > GAMEMODE.InventoryHeight then return end
	
	item.x = x
	item.y = y
	item:UpdateSave()
end)