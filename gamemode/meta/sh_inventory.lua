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

function inventory:get_items()
	return self.items
end

setmetatable(inventory, {__call = inventory.__call})

zonecontrol.meta.inventory = inventory

if SERVER then return end

function inventory:transmit(ply)
	// TODO: Transmit inventory to player
end

function inventory:save()
	zonecontrol.inventory.save(self)
end