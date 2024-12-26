AddCSLuaFile()

zonecontrol = zonecontrol or {}
zonecontrol.meta = zonecontrol.meta or {}

local inventory = {}
inventory.__index = inventory
inventory.inventory = true

function inventory:__tostring()
	return string.format("inventory[%d]", self.id or 0)
end

function inventory:__eq(cmp)
	if not istable(cmp) and not cmp.inventory then error("Attempt to compare inventory with non-inventory object!") end

	return self.id == cmp.id
end

function inventory:__call(id)
	local inv = {
		id = id,
		items = {}
	}

	return setmetatable(inv, self)
end

function inventory:add(item)
	if not istable(item) and not item.IsItem then error("Attempted to add non-item object to inventory!") end
	item.inventory = self

	self.items[item:GetID()] = item
end

function inventory:remove(item)
	local id = item:GetID()
	if not self.items[id] then error("Attempted to remove non-existent item from inventory!") end

	self.items[id] = nil
end

function inventory:set_owner(id)
	self.owner = id
end

function inventory:get_owner()
	if not self.owner then return end

	// TODO: Implement player list by character ID
	for _,ply in pairs(player.GetHumans()) do
		if ply.CharID and ply:CharID() == self.owner then
			return ply
		end
	end
end

function inventory:get_items()
	return self.items
end

function inventory:unload()
	for id,item in pairs(self.items) do
		if item.OnUnload then
			item:OnUnload()
		end
	end

	zonecontrol.inventory.list[self.id] = nil
end

function inventory:can_access(ply)
	if not self.owner then return true end

	return ply:CharID() == self.owner
end

function inventory:get_weight()
	local weight = 0
	for _,item in pairs(self.items) do
		weight = weight + item:GetWeight()
	end
	return weight
end

setmetatable(inventory, {__call = inventory.__call})

zonecontrol.meta.inventory = inventory

if not SERVER then return end

util.AddNetworkString("NetworkInventory")

function inventory:transmit(ply)
	net.Start("NetworkInventory")
		net.WriteUInt(self.id, 32)
		net.WriteUInt(self.owner or 0, 32)
	net.Send(ply)

	local idx = 1
	local item_count = table.Count(self.items)
	local item_ids = table.GetKeys(self.items)
	hook.Add("Think", "NetworkInventoryItems" .. self.id, function()
		local item = self.items[item_ids[idx]]
		item:Transmit(ply)

		if idx == item_count then
			hook.Remove("Think", "NetworkInventoryItems" .. self.id)
		end

		idx = idx + 1
	end)
end

function inventory:save()
	zonecontrol.inventory.save(self)
end