zonecontrol = zonecontrol or {}
zonecontrol.item = zonecontrol.item or {}
zonecontrol.item.list = zonecontrol.item.list or {}

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

	local item = zonecontrol.item.list[id]
	if item then
		item:SetVar(key, value)
	end
end
net.Receive("NetworkItemVar", NetworkItemVar)

local function NetworkItemFunction()
	local id = net.ReadUInt(32)
	local key = net.ReadString()

	local item = zonecontrol.item.list[id]
	if item then
		item:CallFunction(key)
	end
end
net.Receive("NetworkItemFunction", NetworkItemFunction)

local function NetworkItemDrop()
	local id = net.ReadUInt(32)

	local item = zonecontrol.item.list[id]
	if item then
		item:DropItem()
	end
end
net.Receive("NetworkItemDrop", NetworkItemDrop)

local function NetworkItemUnload()
	local id = net.ReadUInt(32)

	local item = zonecontrol.item.list[id]
	if item then
		item:OnUnload()
	end
end
net.Receive("NetworkItemUnload", NetworkItemUnload)