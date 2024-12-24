AddCSLuaFile();

local item = {};
item.__index = item;
item.IsItem = true;
item.W = 1
item.H = 1
function item:__tostring()
	return "item[" .. (self.id or 0) .. "]"
end

function item:New(metaitem, id, vars)
	if !metaitem then return end
	if isstring(metaitem) then
		metaitem = GAMEMODE:GetItemByID(metaitem)
	end
	if !metaitem then return end -- yeah not exactly amazing

	local itemdata = {};
	for k,v in next, metaitem do
		itemdata[k] = v
	end

	if id then
		itemdata["id"] = id
	end

	if vars and istable(vars) then
		itemdata["Vars"] = vars
	else
		itemdata["Vars"] = metaitem.Vars or {}
	end

	setmetatable(itemdata, item)

	if itemdata.Initialize then
		itemdata:Initialize()
	end

	if id then
		GAMEMODE.g_ItemTable[id] = itemdata
	end

	return itemdata
end

function item:GetName()
	return self.Name -- cool thing about these funcs is you are able to override in ur item code.
end

function item:GetDesc()
	return self.Desc
end

function item:GetWeight()
	if self.Stackable then
		local meta = GAMEMODE:GetItemByID(self.Class)
		local start_amount = meta.Vars.Stacked
		local start_weight = self:GetVar("Weight", self.Weight)

		return math.Round(start_weight * (self:GetVar("Stacked", 0) / start_amount), 2)
	else
		return self:GetVar("Weight", self.Weight)
	end
end

function item:GetModel()
	return self.Model
end

function item:GetVars(private)
	local tbl = table.Copy(self.Vars) or {}
	if !private then
		tbl["PrivateVars"] = nil
	end

	return tbl
end

function item:CanSell()
	return self.IsSellable
end

if SERVER then
	util.AddNetworkString("NetworkItemVar")
end

function item:SetVar(key, value, noSave, network)
	if !self.Vars then
		self.Vars = {}
	end

	if self.Vars[key] == value then return end

	self.Vars[key] = value

	if SERVER then
		if network then
			net.Start("NetworkItemVar")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString(key)
				net.WriteType(value)
			net.Send(self:GetInventory():get_owner())
		end

		if !noSave then
			local query = CCSQL:prepare("INSERT INTO `cc_item_data` (`item`, `type`, `varkey`, `value`) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE `type`=?, `value`=?;")
			query.onError = function(_, err)
				error(err)
			end
			query:setNumber(1, self:GetID())
			query:setString(2, type(value))
			query:setString(3, key)
			query:setString(4, util.TypeToString(value))
			query:setString(5, type(value))
			query:setString(6, util.TypeToString(value))
			query:start()
		end
	end
end

function item:GetVar(key, fallback)
	if !self.Vars then return fallback end

	return table.Copy(self.Vars)[key] or fallback
end

function item:GetClass()
	return self.Class
end

function item:GetID()
	return self.id or 0
end

function item:SetID(nID)
	self.id = nID
end

function item:GetSize()
	return self.W, self.H
end

function item:GetInventory()
	return self.inventory or zonecontrol.inventory.list[0]
end

function item:CallFunction(szKey, bNetwork)
	if self.functions and self.functions[szKey] and self.functions[szKey].CanRun(self) then
		if self.FunctionHooks and self.FunctionHooks["Pre" .. szKey] then
			self.FunctionHooks["Pre" .. szKey](self)
		end

		if bNetwork then
			if SERVER then
				netstream.Start(self:Owner(), "CallFunction", self:GetID(), szKey)
			else
				netstream.Start("ItemCallFunction", self:GetID(), szKey)
			end
		end

		local ret = self.functions[szKey].OnUse(self)

		if self.FunctionHooks and self.FunctionHooks["Post" .. szKey] then
			self.FunctionHooks["Post" .. szKey](self)
		end

		if self.functions[szKey].RemoveOnUse and ret then
			self:RemoveItem();
		end

		return ret
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

	self.x = -1
	self.y = -1

	if( SERVER ) then

		if network then
			netstream.Start(self:Owner(), "DropItem", self:GetID())
		end

		kingston.log.write("items", "[%s (%s)(%s)] dropped item %s [ID: %d]", self:Owner():RPName(), self:Owner():Nick(), self:Owner():SteamID(), self:GetName(), self:GetID())

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

	if self.OnDeleted then
		self:OnDeleted()
	end

	GAMEMODE.g_ItemTable[self:GetID()] = nil;

	if self:Owner() and self:Owner():IsValid() and self:Owner():IsPlayer() then
		self:Owner().Inventory[self:GetID()] = nil;

		hook.Run("ItemDropped", self:Owner(), self)
	end

	setmetatable( self, nil );
	self = nil;

end

function item:OnNewCreation()

end

function item:DynamicFunctions()

	return {};

end

-- return true here to refresh the inventory
function item:OnStack(item)
	if !self.Stackable then return end

	self:SetVar("Stacked", self:GetVar("Stacked", 0) + item:GetVar("Stacked", 0), nil, true)
	item:RemoveItem(true)

	return true
end

function item:CanStack(item)
	if self.Stackable and item.Stackable and item.Base == self.Base and self.Class == item.Class then
		return true
	end
end

function item:Paint(pnl, w, h)
	if !self.Stackable then return end

	surface.SetFont("SmallChatFont")
	local amt = self:GetVar("Stacked", 0)
	local tW, tH = surface.GetTextSize(amt)

	surface.SetTextColor(Color(100,200,100))
	surface.SetTextPos(w - tW, h - tH)
	surface.DrawText(amt)
end

function item:CanSplitStack(amt)
	if !self.Stackable then return end

	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end

	return (amt > 0 and self:GetVar("Stacked", 0) > 1) and (amt < self:GetVar("Stacked", 0))
end

function item:SplitStack(amt, x, y)
	if !self.Stackable then return end

	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end

	if amt >= self:GetVar("Stacked", 0) then return end

	self:SetVar("Stacked", self:GetVar("Stacked", 0) - amt, false, true)

	local item = self:Owner():GiveItem(self.Class, {
		Stacked = amt,
	}, x, y)
end

function item:AddItemToStack(item)
	if !self.Stackable then return end
	if item and !item.Stackable then return end

	if item then
		self:OnStack(item)
	else
		local metaitem = GAMEMODE:GetItemByID(self:GetClass())
		self:SetVar("Stacked", self:GetVar("Stacked", 0) + (metaitem.Vars.Stacked or 1), nil, true)
	end
end

function item:SaveNewObject(callback)
	if !SERVER then return end

	local query = CCSQL:prepare("INSERT INTO `cc_items` (Inventory, ItemClass) VALUES (?, ?);")
	query.onSuccess = function(_, ret)
		local id = query:lastInsert()
		local insertTable = {
			["id"] = id,
		}

		table.Merge(self, insertTable)

		GAMEMODE.g_ItemTable[id] = self

		if self.OnNewCreation then
			self:OnNewCreation()
		end

		if callback then
			callback()
		end
	end
	function query:onError( err )
		MsgC(Color(255, 0, 0), "MySQL Query failed: " .. err)
	end
	query:setNumber(1, self:GetInventory().id)
	query:setString(2, self:GetClass())
	query:start()
end

if SERVER then
	util.AddNetworkString("NetworkItem")
end
function item:Transmit(ply, dummy)
	if not SERVER then return end

	if dummy then
		net.Start("NetworkItem")
			net.WriteUInt(self:GetID(), 32)
			net.WriteString(self:GetClass())
			net.WriteTable(self:GetVars())

			net.WriteBool(true)
			net.WriteEntity(self:Owner())
		net.Send(ply)
	else
		net.Start("NetworkItem")
			net.WriteUInt(self:GetID(), 32)
			net.WriteString(self:GetClass())
			net.WriteTable(self:GetVars())

			net.WriteBool(false)
			net.WriteUInt(self:GetInventory().id, 32)
		if ply then
			net.Send(ply)
		else
			net.Broadcast()
		end
	end
end

function item:DeleteItem()
	if !SERVER then return end

	local function onSuccess()
	end
	mysqloo.Query(Format("DELETE FROM cc_items WHERE id = '%d'", self:GetID()), onSuccess)
end

setmetatable( item, { __call = item.New } )

zonecontrol = zonecontrol or {}
zonecontrol.meta = zonecontrol.meta or {}
zonecontrol.meta.item = item