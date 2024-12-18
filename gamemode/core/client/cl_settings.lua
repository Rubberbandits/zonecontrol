zonecontrol = zonecontrol or {}
zonecontrol.settings = zonecontrol.settings or {}
zonecontrol.settings.map = zonecontrol.settings.map or {}
zonecontrol.settings.default = zonecontrol.settings.default or {
	music_volume = {type = "float", category = "sound", text = "Music Volume", default = 1.0},
	cutscene_volume = {type = "float", category = "sound", text = "Cutscene Volume", default = 1.0},
	stalker_cursor = {type = "bool", category = "display", text = "Stylized Cursor", default = false}
}
zonecontrol.settings.categories = zonecontrol.settings.categories or {
	"sound",
	"display",
	"controls"
}

for key, data in pairs(zonecontrol.settings.default) do
	language.Add(key, data.text)
end

function zonecontrol.settings.load()
	local f = file.Open("zonecontrol/settings.txt", "r", "DATA")
	if not f then hook.Run("SettingsLoaded") return end

	hook.Add("Think", "LoadSettings", function()
		if f:EndOfFile() then f:Close() hook.Remove("Think", "LoadSettings") hook.Run("SettingsLoaded") return end

		local setting = f:ReadLine()
		local split = string.Split(setting, "=")
		local key = split[1]
		local settings_data = zonecontrol.settings.default[key]
		if not settings_data then return end

		zonecontrol.settings.map[key] = util.StringToType(split[2], settings_data.type)
	end)
end

function zonecontrol.settings.save()
	local f = file.Open("zonecontrol/settings.txt", "w", "DATA")
		for key,value in pairs(zonecontrol.settings.map) do
			f:Write(string.format("%s=%s\n", key, util.TypeToString(value)))
		end
	f:Close()

	hook.Run("SettingsSaved")
end

function zonecontrol.settings.new(key, type, category, text, default)
	zonecontrol.settings.default[key] = {type = type, category = category, text = text, default = default}
end

function zonecontrol.settings.set(key, value)
	if not zonecontrol.settings.default[key] then error(string.format("Attempted to set invalid setting: %s", key)) end

	zonecontrol.settings.map[key] = value
	zonecontrol.settings.save()
	hook.Run("SettingsChanged", key, value)
end

function zonecontrol.settings.get(key)
	if not zonecontrol.settings.default[key] then return end
	return zonecontrol.settings.map[key] or zonecontrol.settings.default[key].default
end

hook.Add("OnGamemodeLoaded", "LoadSettings", function()
	zonecontrol.settings.load()
end)

hook.Add("ShutDown", "SaveSettings", function()
	zonecontrol.settings.save()
end)