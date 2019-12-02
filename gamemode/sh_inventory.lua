local meta = FindMetaTable( "Player" );

function meta:LoadItemsFromString( str )
	
	self.Inventory = {};
	
	self.Inventory = util.JSONToTable( str ) or self.Inventory;
	
	netstream.Start( self, "nLoadInventory", self.Inventory );
	
end

function meta:SaveInventory()
	
	local str = util.TableToJSON( self.Inventory );
	
	self:UpdateCharacterField( "Inventory", str );
	
end

if( CLIENT ) then
	
	local function nLoadInventory( inv )

		LocalPlayer().Inventory = inv;
		
	end
	netstream.Hook( "nLoadInventory", nLoadInventory );
	
	local function nGiveItem( item, n )

		LocalPlayer():GiveItem( item, n );
		
	end
	netstream.Hook( "nGiveItem", nGiveItem );
	
	local function nRemoveItem( k )
		local item = LocalPlayer().Inventory[k]
		
		if item then
			item:RemoveItem()
		end
	end
	netstream.Hook( "nRemoveItem", nRemoveItem );
	
	local function nTooHeavy()
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "That's too heavy for you to carry.", { CB_ALL, CB_IC } );
		
	end
	netstream.Hook( "nTooHeavy", nTooHeavy );
	
else
	
	local function nRemoveItem( ply, k )
		local item = ply.Inventory[k]
		
		if item then
			item:RemoveItem()
		end
	end
	netstream.Hook( "nRemoveItem", nRemoveItem );
	
	local function nDropItem( ply, k )

		local item = ply.Inventory[k];
		
		if( !k ) then return end
		if( !item:CanDrop() ) then return end
		
		GAMEMODE:LogItems( "[D] " .. ply:VisibleRPName() .. " dropped item " .. item:GetName() .. ".", ply );

		item:DropItem()
		
	end
	netstream.Hook( "nDropItem", nDropItem );
	
	local function nSellItemToMenu( ply, k )
	
		local item = ply.Inventory[k];
		
		if !GAMEMODE.SellToMenuEnabled then return end
		if( !item ) then return end
		if( item:GetVar("Equipped",false) ) then return end
		
		if( item and ply:HasCharFlag( "X" ) and InStockpileRange( ply ) ) then
		
			local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
			if( !metaitem.BulkPrice ) then return end
			if metaitem.CanSell then
			    if !item:CanSell() then
			        return
			    end
		    end
		
		    local sell_price = GAMEMODE:CalculatePrice(item)
		
			item:RemoveItem()
			ply:SetMoney( ply:Money() + sell_price );
			ply:UpdateCharacterField( "Money", ply:Money() );
			netstream.Start( ply, "nSellItemMessage", sell_price, metaitem.Name );
		end
	
	end
	netstream.Hook( "nSellItemToMenu", nSellItemToMenu )
	
end

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
	
	if( !self.Inventory ) then return 0 end
	
	local w = 0;
	
	for _, v in pairs( self.Inventory ) do
		
		local meta = GAMEMODE:GetItemByID( v:GetClass() );
		if( meta and meta.Weight ) then
			
			w = w + v:GetWeight();
			
		end
		
	end
	
	return w;
	
end

function meta:InventoryMaxWeight()
	
	local w = 10 + math.Round( self:Strength() * 0.2 );

	local classes = {}
	if( self.Inventory ) then
		for k,v in next, self.Inventory do
			local metaitem = GAMEMODE:GetItemByID(v:GetClass())
			if metaitem.GetCarryWeight then
				if !metaitem.Stackable and classes[v:GetClass()] then continue end
				
				w = w + v:GetCarryWeight()
				
				if !classes[v:GetClass()] then
					classes[v:GetClass()] = true
				end
			end
		end
	end
	
	return w;
	
end

function meta:GiveItem( item_class, vars )
	
	GAMEMODE:LogItems( "[G] " .. self:VisibleRPName() .. " obtained item " .. item_class .. ".", self );
	
	if( !GAMEMODE:GetItemByID( item_class ) ) then

		return;
		
	end

	local object = item( self, item_class );
	
	if( Vars ) then
		
		object.Vars = Vars;
		
	end
	
	local function cb()

		self.Inventory[object.id] = object
		netstream.Start( self, "ReceiveItem", item_class, object.id, object.Vars or {} );
		
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
		GAMEMODE:PMUpdateInventory();
		
	end

end

function meta:ThrowOutItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	if( self:IsItemEquipped( self.Inventory[self:GetDutyInventory()][k] ) ) then return end
	
	if( CLIENT ) then
	
		local metaitem = GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] );
	
		if( metaitem.OnRemoved ) then

			metaitem.OnRemoved( self.Inventory[self:GetDutyInventory()][k], self );
			
		end

		netstream.Start( "nRemoveItem", k, true );
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
	CC.Me( self, Format( " destroys their %s.", GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).Name ), true );
	
end

function meta:DropItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then

		local item = self.Inventory[k]
		item:DropItem()
		netstream.Start( "nDropItem", k );
		GAMEMODE:PMUpdateInventory();
		
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
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
end

function meta:TakeFromStockpile( k, id )

	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then

		netstream.Start( "nTakeFromStockpile", k, id );
		
	end

end

function meta:GetWeight()

	local nWeight = 0;
	for k,v in next, self.Inventory do
		
		nWeight = nWeight + v:GetWeight();

	end
	
	return nWeight;

end