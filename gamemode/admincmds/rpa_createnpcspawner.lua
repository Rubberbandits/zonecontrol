

kingston.admin.registerCommand("createnpcspawner", {
	syntax = "<none>",
	description = "Spawn a random NPC spawner",
	arguments = {},
	onRun = function(ply)
		local spawner = ents.Create("npc_spawner")
		spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
		spawner:Spawn()

		hook.Run("SaveMutantSpawns")
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " created an NPC spawner.", ply );
	end,
})