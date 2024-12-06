kingston = kingston or {}
kingston.factions = kingston.factions or {}
kingston.factions.spawns = kingston.factions.spawns or {}

function GM:LoadFactions()
	local data = file.Read("zonecontrol/"..game.GetMap().."/factions.txt", "DATA")

	if !data or #data == 0 then return end

	local factionData = util.JSONToTable(data)
	if factionData then
		kingston.factions = factionData
	end
end

function GM:SaveFactions()
	if !file.IsDir("zonecontrol", "DATA") then
		file.CreateDir("zonecontrol")
	end

	if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
		file.CreateDir("zonecontrol/"..game.GetMap())
	end

	file.Write("zonecontrol/"..game.GetMap().."/factions.txt", util.TableToJSON(kingston.factions))
end

hook.Add("InitPostEntity", "STALKER.LoadFactions", function()
	hook.Run("LoadFactions")
end)

hook.Add("ShutDown", "STALKER.SaveFactions", function()
	hook.Run("SaveFactions")
end)