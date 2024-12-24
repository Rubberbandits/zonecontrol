zonecontrol = zonecontrol or {}
zonecontrol.items = zonecontrol.items or {}
zonecontrol.items.list = zonecontrol.items.list or {}

GM.DummyItems = GM.DummyItems or {};

local function NetworkItem(len)
	local id = net.ReadUInt(32)
	local class = net.ReadString()
	local vars = net.ReadTable()

	local dummy = net.ReadBool()
	if dummy then
		local owner = net.ReadEntity()

		local tbl = {
			szClass = class,
			Vars = vars,
			Owner = owner,
			CharID = owner:CharID(),
		}

		hook.Run("OnReceiveDummyItem", s_iID, tbl)
		return
	else
		local inventory_id = net.ReadUInt(32)

		local item = zonecontrol.meta.item(class, id, vars)
		local inventory = zonecontrol.inventory.list[inventory_id]
		inventory:add(item)

		hook.Run("NetworkedItemReceived", item)
	end
end
net.Receive("NetworkItem", NetworkItem)

local function NetworkItemVar()
	local id = net.ReadUInt(32)
	local key = net.ReadString()
	local value = net.ReadType()

	local item = zonecontrol.items.list[id]
	if item then
		item:SetVar(key, value)
	end
end
net.Receive("NetworkItemVar", NetworkItemVar)

netstream.Hook("RemoveItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:RemoveItem()
	end
end)

netstream.Hook("CallFunction", function(id, key)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:CallFunction(key)
	end
end)

netstream.Hook("DropItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:DropItem()
	end
end)

netstream.Hook("UnloadItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:OnUnload()
		LocalPlayer().Inventory[id] = nil
		GAMEMODE.g_ItemTable[id] = nil
	end
end)