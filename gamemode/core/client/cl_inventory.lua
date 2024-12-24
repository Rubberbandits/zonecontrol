zonecontrol = zonecontrol or {}
zonecontrol.inventory = zonecontrol.inventory or {}
zonecontrol.inventory.list = zonecontrol.inventory.list or {}
zonecontrol.inventory.list[0] = zonecontrol.meta.inventory(0)
zonecontrol.inventory.list[0].world = true

local function NetworkInventory()
    local id = net.ReadUInt(32)
    local owner = net.ReadUInt(32)

    zonecontrol.inventory.list[id] = zonecontrol.meta.inventory(id)
    if owner > 0 then
        zonecontrol.inventory.list[id]:set_owner(owner)
    end
end
net.Receive("NetworkInventory", NetworkInventory)

function zonecontrol.inventory.destroy(id)
    zonecontrol.inventory.list[id] = nil
end

function zonecontrol.inventory.get(id)
    return zonecontrol.inventory.list[id]
end