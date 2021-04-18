local function CreateLootSpawner( ply, args )
	local spawner = ents.Create("npc_spawner")
	spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
	spawner:Spawn()

	hook.Run("SaveMutantSpawns")
	
	GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " created NPC spawner.", ply );
end
concommand.AddAdmin( "rpa_createlootspawner", CreateLootSpawner );