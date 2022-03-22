

kingston.admin.registerCommand("gamecreateshipmentspawn", {
	syntax = "<none>",
	description = "Spawn a random shipment location",
	arguments = {},
	onRun = function(ply)
		local spawner = ents.Create("shipment_spawner")
		spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
		spawner:Spawn()

		hook.Run("SaveShipmentSpawns")
		
		GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " created a shipment spawn location.", ply)
	end,
})