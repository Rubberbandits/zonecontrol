zonecontrol = zonecontrol or {}
zonecontrol.inventory = zonecontrol.inventory or {}
zonecontrol.inventory.by_id = zonecontrol.inventory.by_id or {}

function zonecontrol.inventory.create(id)

end

function zonecontrol.inventory.destroy(id)
    zonecontrol.inventory.by_id[id] = nil
end

function zonecontrol.inventory.get(id)
    return zonecontrol.inventory.by_id[id]
end