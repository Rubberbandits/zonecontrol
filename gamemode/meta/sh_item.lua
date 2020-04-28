AddCSLuaFile();

item = {};
item.__index = item;
item.IsItem = true;
function item:__tostring()

	return "item["..( self.id or 0 ).."]";

end

local blacklist = {
	["Vars"] = true,
	["id"] = true,
	["owner"] = true,
	["CharID"] = true,
	["Initialize"] = true,
	["functions"] = true,
	["FunctionHooks"] = true,
	["Class"] = true,
}

function item:New( owner, metaitem, id, vars )

	if( !owner ) then return end
	if( !IsValid( owner ) ) then return end
	if( !metaitem ) then return end
	if( isstring( metaitem ) ) then
	
		metaitem = GAMEMODE:GetItemByID( metaitem );
		
	end
	if( !metaitem ) then return end -- yeah not exactly amazing
	
	local itemdata = {};
	for k,v in next, metaitem do
		if isfunction(v) then continue end
		if blacklist[k] then continue end
		
		itemdata["Get"..k] = function(self)
			return self:GetVar(k, v)
		end
		itemdata["Set"..k] = function(self, value, network)
			self:SetVar(k, value, nil, network) 
		end
	end
	
	for k,v in next, metaitem do
	
		itemdata[k] = v;
	
	end
	
	itemdata["owner"] = owner;
	itemdata["CharID"] = owner:CharID();
	
	if( id ) then
	
		itemdata["id"] = id;
		
	end
	
	if( vars and istable( vars ) ) then

		itemdata["Vars"] = vars;
		
	else

		itemdata["Vars"] = metaitem.Vars or {};
		
	end
	
	setmetatable( itemdata, item );

	itemdata:Initialize();
	
	if( id ) then
	
		GAMEMODE.g_ItemTable[id] = itemdata;
		owner.Inventory[id] = itemdata;
		
	end
	
	return itemdata;

end

function item:GetName()

	return self.Name; -- cool thing about these funcs is you are able to override in ur item code.

end

function item:GetDesc()

	return self.Desc;
	
end

function item:GetWeight()

	return self.Weight;

end

function item:GetModel()

	return self.Model;

end

function item:Owner()

	return self.owner;
	
end

function item:GetVars()

	if( self.Vars ) then
	
		return self.Vars;
		
	end
	
end

function item:CanSell()
	return self.IsSellable
end

function item:StockpileID()
	return self.stockpile or 0
end

function item:SetVar( key, value, noSave, network )

	if( !self.Vars ) then
	
		self.Vars = {}
		
	end

	if( self.Vars[key] == value ) then return end
	
	self.Vars[key] = value;

	if( SERVER ) then
		if network then
			netstream.Start(item:Owner(), "SetItemVar", self:GetID(), key, value)
		end
	
		if !noSave then
			self:UpdateSave()
		end
	end
	
end

function item:GetVar( key, fallback )

	if( !self.Vars ) then return fallback end

	return table.Copy(self.Vars)[key] or fallback;

end

function item:Initialize() -- maybe we can use hook.Run

	-- override when u need obj init cb

end

function item:GetCharID()

	return self.CharID;

end

function item:GetClass()

	return self.Class;
	
end

function item:GetID()

	return self.id or 0;
	
end

function item:SetID( nID )

	self.id = nID;

end

function item:SetCharID( nID )

	self.CharID = nID;
	
end

function item:CallFunction( szKey, bNetwork )
	if( self.functions ) then
		if( self.functions[szKey] ) then
			if( self.functions[szKey].CanRun( self ) ) then
				if( self.FunctionHooks and self.FunctionHooks["Pre"..szKey] ) then
					self.FunctionHooks["Pre"..szKey]( self );
				end
				
				if bNetwork then
					netstream.Start(self:Owner(), "CallFunction", self:GetID(), szKey)
				end
			
				local ret = self.functions[szKey].OnUse( self );
				if( self.functions[szKey].RemoveOnUse and ret ) then

					self:RemoveItem();
					
				end
				
				if( self.FunctionHooks and self.FunctionHooks["Post"..szKey] ) then
					self.FunctionHooks["Post"..szKey]( self );
				end
				
				return ret;
			end
		end
	end
end

function item:CanDrop()

	return true;

end

function item:DropItem(network)

	if( !self:CanDrop() ) then return end
	if( CLIENT ) then
	
		self.CharID = 0;
		self:Owner().Inventory[self:GetID()] = nil;
		self.owner = nil;
		GAMEMODE.g_ItemTable[self:GetID()] = nil;
	
	end
	
	if( SERVER ) then
	
		if network then
			netstream.Start(self:Owner(), "DropItem", self:GetID())
		end
		local ent = GAMEMODE:DropItem( self );
		return ent
		
	end

end

function item:RemoveItem(network)

	if( SERVER ) then
	
		self:DeleteItem();
		
		if network then
			netstream.Start(self:Owner(), "RemoveItem", self:GetID())
		end
		
	end

	GAMEMODE.g_ItemTable[self:GetID()] = nil;
	
	if self:Owner() and self:Owner():IsValid() and self:Owner():IsPlayer() then
		print(self:Owner())
		self:Owner().Inventory[self:GetID()] = nil;
		
		hook.Run("ItemDropped", self:Owner(), self)
	end
	
	setmetatable( self, nil );
	self = nil;
	
	if CLIENT then
		GAMEMODE:PMUpdateInventory()
	end

end

function item:StockpileItem( id )
	local stockpile = GAMEMODE.LoadedStockpiles[id]

	local function onSuccess()
		stockpile.Inventory[self:GetID()] = true
		GAMEMODE.g_ItemTable[self:GetID()] = nil
		self:Owner().Inventory[self:GetID()] = nil
		
		hook.Run("ItemDropped", self:Owner(), self)
		
		setmetatable(self, nil)
		self = nil
	end
	mysqloo.Query(Format("UPDATE cc_items SET Owner = 0, Stockpile = %d WHERE id = %d", id, self:GetID()), onSuccess)
end

function item:OnNewCreation()

end

function item:DynamicFunctions()

	return {};

end

if( SERVER ) then

	function item:SaveNewObject( cb )
	
		local function onSuccess( data, query )
		
			local insertTable = {
				["id"] = query:lastInsert(),
			};
			
			table.Merge( self, insertTable );
			
			GAMEMODE.g_ItemTable[query:lastInsert()] = self;
			self:Owner().Inventory[query:lastInsert()] = self;
			
			if( self.OnNewCreation ) then
			
				self:OnNewCreation();
				
			end
			
			if( cb ) then
			
				cb()
				
			end

		end
		mysqloo.Query( Format( "INSERT INTO cc_items ( Owner, ItemClass, Vars ) VALUES ( '%d', '%s', '%s' )", self:Owner():CharID(), self:GetClass(), util.TableToJSON( self:GetVars() or {} ) ), onSuccess );
	
	end
	
	function item:UpdateSave()
	
		local query_str = "UPDATE cc_items SET Owner = ?, Vars = ?, Stockpile = ? WHERE id = ?"
		local query = CCSQL:prepare( query_str );
		function query:onSuccess( ret )
		end
		function query:onError( err )
		
			MsgC( Color( 255, 0, 0 ), "MySQL Query failed: "..err );
		
		end
		query:setNumber( 1, self:GetCharID() );
		query:setString( 2, util.TableToJSON( self:GetVars() or {} ) );
		query:setNumber( 3, self:StockpileID() );
		query:setNumber( 4, self:GetID() );
		query:start();
	end
	
	-- use this when transferring owners!
	function item:TransmitToOwner()

		netstream.Start( self:Owner(), "ReceiveItem", self:GetClass(), self:GetID(), self:GetVars() );
	
	end

	function item:Transmit( ply ) -- for sending some item info that is only needed for shit like bonemerge
	
		-- if ply is nil, netstream broadcasts to all clients.
		netstream.Start( ply, "ReceiveDummyItem", self:GetID(), self:GetClass(), self:GetVars(), self:Owner(), self.CharID );
		self.IsTransmitted = true; -- for join in progress, client asks server to supply all dummy items.
	
	end
	
	function item:DeleteItem()
	
		local function onSuccess()
		end
		mysqloo.Query( Format( "DELETE FROM cc_items WHERE id = '%d'", self:GetID() ), onSuccess );
	
	end
	
end
	
setmetatable( item, { __call = item.New } )