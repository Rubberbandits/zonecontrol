local argtoenum = {
	["worthless"] = LOOT_WORTHLESS,
	["common"] = LOOT_COMMON,
	["uncommon"] = LOOT_UNCOMMON,
	["rare"] = LOOT_RARE,
	["legendary"] = LOOT_LEGENDARY,
}

local function CreateLootSpawner( ply, args )
	local category = argtoenum[args[1] or "common"];
	
	if( category ) then
		
		local spawner = ents.Create("loot_spawner")
		spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
		spawner:SetLootCategory(category)
		spawner:Spawn()

		hook.Run("SaveLootSpawns")
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " created loot spawner with category \"" .. args[1] .. "\"", ply );

	end
	
end
concommand.AddAdmin( "rpa_createlootspawner", CreateLootSpawner );