local meta = FindMetaTable( "Player" );

function meta:HasItem( itemid )
	if !self.Inventory then return end

	local items = {}
	for k,v in next, self.Inventory do
		if v:GetClass() == itemid then
			items[#items + 1] = v
		end
	end

	if #items == 1 then
		return items[1]
	elseif #items > 1 then
		return items
	end

	return false
end

function meta:InventoryWeight()
	local inventory = zonecontrol.inventory.by_charid[self:CharID()]
	if not inventory then return 0 end

	return inventory:get_weight()
end

function meta:InventoryMaxWeight()

	local w = 10 + math.Round( self:Strength() * 0.2 );

	local classes = {}
	if( self.Inventory ) then
		for k,v in next, self.Inventory do
			local metaitem = GAMEMODE:GetItemByID(v:GetClass())
			if metaitem.GetCarryWeight then
				if !metaitem.StackCarryWeight and classes[v:GetClass()] then continue end

				w = w + v:GetCarryWeight()

				if !classes[v:GetClass()] then
					classes[v:GetClass()] = true
				end
			end
		end
	end

	w = hook.Run("GetInventoryMaxWeight", self, w)

	return w;

end

function GM:GetInventoryMaxWeight(ply, weight)
	return weight
end

function meta:GiveItem( item_class, vars, x, y )

	if( !GAMEMODE:GetItemByID( item_class ) ) then

		return;

	end

	local object = item( self, item_class, nil, nil, x, y );

	if( vars ) then

		table.Merge(object.Vars, vars)

	end

	local function cb()

		self.Inventory[object.id] = object
		netstream.Start( self, "ReceiveItem", item_class, object.id, object.Vars or {}, object.x, object.y );
		kingston.log.write("items", "[%s (%s)(%s)] acquired item %s [ID: %d]", self:RPName(), self:Nick(), self:SteamID(), object:GetName(), object:GetID())

	end
	object:SaveNewObject( cb );

	return obj;

end

function meta:SellItemToMenu( k )

	if !GAMEMODE.SellToMenuEnabled then return end
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	if !InStockpileRange(LocalPlayer()) then return end
	if( !self:HasCharFlag( "X" ) ) then return end

	local item = self.Inventory[k]
	if !item then return end
	if item:GetVar("Equipped", false) then return end

	if( CLIENT ) then

		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );

		if( !metaitem.BulkPrice ) then return end

		netstream.Start( "nSellItemToMenu", k );
		item:RemoveItem()
		if GAMEMODE.Inventory then
			GAMEMODE.Inventory:PopulateItems()
		end

	end

end

function meta:MoveToStockpile( k, id )

	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end

	local item = self.Inventory[k]

	if !item then return end
	if !item:CanDrop() then return end

	if( CLIENT ) then

		GAMEMODE.g_ItemTable[item:GetID()] = nil;
		self.Inventory[item:GetID()] = nil;
		setmetatable( item, nil );
		item = nil;

		netstream.Start( "nMoveToStockpile", k, id );

		GAMEMODE.Inventory:PopulateItems()

	end

end

function meta:TakeFromStockpile( k, id )

	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end

	if( CLIENT ) then

		netstream.Start( "nTakeFromStockpile", k, id );

	end

end