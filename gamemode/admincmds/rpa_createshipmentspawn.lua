local function CreateShipmentSpawn( ply, args )
	local spawner = ents.Create("shipment_spawner")
	spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
	spawner:Spawn()

	hook.Run("SaveShipmentSpawns")
	
	GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " created shipment spawn location.", ply );
end
concommand.AddAdmin( "rpa_createshipmentspawn", CreateShipmentSpawn );