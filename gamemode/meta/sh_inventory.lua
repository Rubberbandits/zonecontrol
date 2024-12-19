AddCSLuaFile()

inventory = {}
inventory.__index = inventory
inventory.inventory = true
inventory.items = {}

setmetatable(inventory, {})

function inventory:__tostring()
	return string.format("inventory[%d]", self.id or 0)
end

function inventory:__eq(cmp)
	if not istable(cmp) and not cmp.inventory then error("Attempt to compare inventory with non-inventory object!") end

	return self.id == cmp.id
end

function inventory:__call(id)
	local inv = {
		id = id
	}

	return setmetatable(inv, self)
end

function inventory:add(item)
	if not istable(item) and not item.IsItem then error("Attempted to add non-item object to inventory!") end

	self.items[item:GetID()] = item
end

function inventory:remove(id)
	if not self.items[id] then error("Attempted to remove non-existent item from inventory!") end

	self.items[id] = nil
end

if SERVER then return end

function inventory:transmit(ply)
	// TODO: Transmit inventory to player
end