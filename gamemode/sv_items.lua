kingston = kingston or {}
kingston.item = kingston.item or {}

kingston.item.item_requests = kingston.item.item_requests or {}

function kingston.item.gm_request_item(gamemaster, item_class, data, reason)
	if !gamemaster:HasPermission("itemcreate") then
		local metaitem = GAMEMODE:GetItemByID(item_class)

		kingston.item.item_requests[#kingston.item.item_requests + 1] = {
			requester = gamemaster,
			class = item_class,
			vars = data,
			reason = reason
		}
		
		netstream.Start(player.GetAdmins(), "nAddNotification", Format("Player %s (%s) is requesting item %s (%s)", gamemaster:Nick(), gamemaster:RPName(), (data or {}).Name or metaitem.Name, item_class))
	else
		gamemaster:GiveItem(item_class, data)
		gamemaster:Notify(nil, COLOR_NOTIF, "Item spawned in inventory")
		kingston.log.write("admin", "%s (%s) spawned %s", gamemaster:Nick(), gamemaster:SteamID(), item_class)
	end
end

function kingston.item.approve_gm_item(id)
	local request = kingston.item.item_requests[id]
	if !request then return end
	
	request.requester:GiveItem(request.class, request.vars)
	netstream.Start(request.requester, "nAddNotification", Format("Your request for item %s was approved.", request.class))
	kingston.log.write("admin", "%s (%s) spawned %s", request.requester:Nick(), request.requester:SteamID(), request.class)
	
	kingston.item.item_requests[id] = nil
end

/* Gamemode Hooks */

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
	hook.Run("SpeedThink", ply)

	local Encumbered = ply:InventoryWeight() > ply:InventoryMaxWeight()
	if !ply.LastEncumberanceState and Encumbered then
		ply:Notify(nil, Color(255,100,0), "You're now over-encumbered.")
	elseif ply.LastEncumberanceState and !Encumbered then
		ply:Notify(nil, Color(255,100,0), "You're no longer over-encumbered.")
	end

	ply.LastEncumberanceState = Encumbered
end

function GM:ItemPickedUp( ply, item )
	if !isstring(item) then
		if item:GetClass() == "pda" then
			if item:GetVar("Primary",false) then
				item:SetVar("Primary", false, nil, true)
			end
		end
		
		kingston.log.write("items", "[%s (%s)(%s)] picked up item %s [ID: %d]", ply:RPName(), ply:Nick(), ply:SteamID(), item:GetName(), item:GetID())
	end

	if isstring(item) then
		local metaitem = GAMEMODE:GetItemByID(item)
		
		if metaitem and metaitem.PickupSound then
			ply:EmitSound(metaitem.PickupSound, 75, 100, 1, CHAN_ITEM)
		end
	else
		if item and item.PickupSound then
			ply:EmitSound(item.PickupSound, 75, 100, 1, CHAN_ITEM)
		end
	end
	
	hook.Run("UpdateEncumberance", ply, item)
end

function GM:ItemDropped( ply, item )
	-- when this is called, the entity hasnt actually
	-- been created yet. 

	hook.Run("UpdateEncumberance", ply, item)
end

function GM:MoneyGiven(giver, receiver, amount)
	local giver_msg = Format("You've given %d RU to %s", amount, receiver:RPName())
	giver:PDANotify("Message", giver_msg, 5, 7)
	
	local receiver_msg = Format("You've received %d RU from %s", amount, giver:RPName())
	receiver:PDANotify("Message", receiver_msg, 5, 8)
	
	kingston.log.write("items", "Player %s (%s) has given %s (%s) %d rubles.", giver:RPName(), giver:Nick(), receiver:RPName(), receiver:Nick(), amount)
end

/* Networking */

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

netstream.Hook("RetrieveDummyItems", function(ply)
	local transmittedItems = {}
	local index = 0

	for _,item in next, GAMEMODE.g_ItemTable do
		if item.IsTransmitted  then
			table.insert(transmittedItems, v)
		end
	end

	hook.Add("Think", "STALKER.TransmitItems"..ply:UserID(), function()
		local item = transmittedItems[index]
		index = index + 1

		netstream.Start(ply, "ReceiveDummyItem", item:GetID(), item:GetClass(), item:GetVars(), item:Owner(), item.CharID)

		if index == #transmittedItems then
			hook.Remove("Think", "STALKER.TransmitItems"..ply:UserID())
		end
	end)
end)

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

netstream.Hook("RequestItemSpawn", function(ply, item_class, data, reason)
	if !item_class then return end
	if !GAMEMODE:GetItemByID(item_class) then return end
	
	-- need to do minmax checking and auth
	
	kingston.item.gm_request_item(ply, item_class, data, reason)
end)

netstream.Hook("AdminRequestedItems", function(ply)
	if !ply:IsAdmin() then return end
	
	netstream.Start(ply, "AdminRequestedItems", kingston.item.item_requests)
end)

util.AddNetworkString("zcRepairItem")
local function zcRepairItem(len, ply)
	if !ply:IsMaintainTech() then return end
	if !InStockpileRange(ply) then return end

	local itemID = net.ReadUInt(32)
	local item = ply.Inventory[itemID]
	if !item then return end

	local metaitem = GAMEMODE:GetItemByID(item:GetClass())
	local repairAmount = net.ReadUInt(8)
	local itemCondition = item:GetVar("Durability", 0)

	if itemCondition + repairAmount > metaitem.Vars.Durability then return end

	local requiredItem = item.RepairPart
	local partsRequired = math.ceil(item.RepairCost / (metaitem.Vars.Durability / repairAmount))

	local items = ply:HasItem(requiredItem)
	if !items then return end
	if partsRequired > 1 and items.IsItem then return end
	if partsRequired > #items then return end

	item:SetVar("Durability", itemCondition + repairAmount, false, true)
	if !items.IsItem then
		for i = 1, partsRequired do
			local item = items[i]
			item:RemoveItem(true)
		end
	else
		items:RemoveItem(true)
	end

	ply:Notify(nil, COLOR_NOTIF, "Repair completed successfully.")
end
net.Receive("zcRepairItem", zcRepairItem)

local BUNDLE_AMOUNTS = {
	1000,
	5000,
	10000
}

util.AddNetworkString("zcBundleMoney")
local function zcBundleMoney(len, ply)
	local bundleOption = net.ReadUInt(4)
	local bundleAmount = BUNDLE_AMOUNTS[bundleOption]

	if !bundleAmount then return end
	if ply:Money() < bundleAmount then return end

	ply:AddMoney(-bundleAmount)
	ply:UpdateCharacterField("Money", ply:Money())

	ply:GiveItem("rubles", {Stacked = bundleAmount})
end
net.Receive("zcBundleMoney", zcBundleMoney)