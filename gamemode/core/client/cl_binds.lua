zonecontrol = zonecontrol or {}
zonecontrol.binds = zonecontrol.binds or {}
zonecontrol.binds.map = zonecontrol.binds.map or {}

function zonecontrol.binds.get(key_code)
	return zonecontrol.binds.map[key_code]
end

// Overrides any binds that happen to also be mapped to something in the gamemode.
function GM:PlayerBindPress(ply, bind, down, key_code)
	if down and zonecontrol.binds.get(key_code) then
		return true
	end
end

local is_down = {}

function GM:PlayerButtonDown(ply, key_code)
	if is_down[key_code] then return end

	if zonecontrol.binds.get(key_code) == "open_inventory" then
		zonecontrol.TestInventory()
	end

	is_down[key_code] = true
end

function GM:PlayerButtonUp(ply, key_code)
	is_down[key_code] = nil
end

hook.Add("OnGamemodeLoaded", "RegisterBindSettings", function()
	zonecontrol.settings.new("open_inventory", "int", KEY_I)
	zonecontrol.settings.new("open_main_menu", "int", KEY_F1)
end)

hook.Add("SettingsLoaded", "LoadBinds", function()
	zonecontrol.binds.map[zonecontrol.settings.get("open_inventory")] = "open_inventory"
	zonecontrol.binds.map[zonecontrol.settings.get("open_main_menu")] = "open_main_menu"
end)

hook.Add("SettingsChanged", "UpdateBinds", function(key, value)
	if not zonecontrol.binds.map[value] then return end
	zonecontrol.binds.map[value] = key
end)