zonecontrol = zonecontrol or {}
zonecontrol.inventory = zonecontrol.inventory or {}
zonecontrol.inventory.list = zonecontrol.inventory.list or {}

function zonecontrol.inventory.create(id)

end

function zonecontrol.inventory.destroy(id)
    zonecontrol.inventory.list[id] = nil
end

function zonecontrol.inventory.get(id)
    return zonecontrol.inventory.list[id]
end