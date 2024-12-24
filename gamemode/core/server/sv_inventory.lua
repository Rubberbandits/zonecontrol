zonecontrol = zonecontrol or {}
zonecontrol.inventory = zonecontrol.inventory or {}
zonecontrol.inventory.list = zonecontrol.inventory.list or {}
zonecontrol.inventory.list[0] = zonecontrol.meta.inventory(0)
zonecontrol.inventory.list[0].world = true

local InventoryTable = {
	{"Owner", "INT", "0"}
}

hook.Add("InitSQLTables", "InitInventoryTable", function()
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_inventories (id INT NOT NULL auto_increment, PRIMARY KEY (id));")

	GAMEMODE:InitSQLTable(InventoryTable, "cc_inventories")
end)

local FETCH_INVENTORY = [[SELECT `Owner` FROM `cc_inventories` WHERE `id` = ?;]]
local FETCH_INVENTORIES = [[SELECT `id`, `Owner` FROM `cc_inventories`;]]
local FETCH_INVENTORY_BY_OWNER = [[SELECT `id` FROM `cc_inventories` WHERE `Owner` = ?;]]
local FETCH_INVENTORY_ITEMS = [[SELECT `cc_items`.`id`, `cc_items`.`ItemClass`, `cc_item_data`.`type`, `cc_item_data`.`varkey`, `cc_item_data`.`value` FROM `cc_items` LEFT JOIN `cc_item_data` ON `cc_item_data`.`item` = `cc_items`.`id` WHERE `cc_items`.`Inventory` = ?;]]

function zonecontrol.inventory.load(id, callback)
	if not id or not isnumber(id) then error("invalid id argument specified") end
	local inventory = zonecontrol.inventory.list[id]
	if not inventory then error("inventory is not initialized") end

	// Loads all items from inventory
	local query = CCSQL:prepare(FETCH_INVENTORY_ITEMS)
	query.onSuccess = function(_, results)
		for _,row in pairs(results) do
			local item_id = row.id
			local item = inventory.items[item_id] or zonecontrol.meta.item(row.ItemClass, item_id)
			if not item.inventory then
				item.inventory = inventory
			end

			if row.type then
				item.Vars = item.Vars or {}
				item.Vars[row.varkey] = util.StringToType(row.value, row.type)
			end

			inventory.items[item_id] = item
		end

		callback(inventory)
	end
	query:setNumber(1, id)
	query:start()
end

// Loads basic inventory information
function zonecontrol.inventory.fetch(id, callback)
	local query = CCSQL:prepare(id and FETCH_INVENTORY or FETCH_INVENTORIES)
	query.onSuccess = function(_, results)
		for _,row in pairs(results) do
			local inventory = zonecontrol.meta.inventory(id)
			if row.Owner > 0 then
				inventory:set_owner(row.Owner)
			end

			zonecontrol.inventory.list[id] = inventory
		end

		callback()
	end

	if id then
		query:setNumber(1, id)
	end

	query:start()
end

function zonecontrol.inventory.fetch_by_character(id, callback)
	local query = CCSQL:prepare(FETCH_INVENTORY_BY_OWNER)
	query.onSuccess = function(_, results)
		local row = results[1]
		local inventory = zonecontrol.meta.inventory(row.id)
		inventory:set_owner(id)

		zonecontrol.inventory.list[row.id] = inventory

		callback(inventory)
	end
	query:setNumber(1, id)
	query:start()
end

local CREATE_INVENTORY = [[INSERT INTO `cc_inventories` (`Owner`) VALUES (?);]]

function zonecontrol.inventory.create(owner_id, callback)
	owner_id = owner_id or 0

	local query = CCSQL:prepare(CREATE_INVENTORY)
	query.onSuccess = function(_, results)
		local inventory_id = query:lastInsert()
		local inventory = zonecontrol.meta.inventory(inventory_id)
		if owner_id > 0 then
			inventory:set_owner(owner_id)
		end

		zonecontrol.inventory.list[inventory_id] = inventory

		callback(inventory)
	end
	query:setNumber(1, owner_id)
	query:start()
end

function zonecontrol.inventory.save(inventory, callback)

end

function zonecontrol.inventory.destroy(id, callback)

end

function zonecontrol.inventory.put(id, item)

end