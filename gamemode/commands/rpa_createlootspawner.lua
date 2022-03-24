local argtoenum = {
	["worthless"] = LOOT_WORTHLESS,
	["common"] = LOOT_COMMON,
	["uncommon"] = LOOT_UNCOMMON,
}



kingston.admin.registerCommand("gamecreatelootspawner", {
	syntax = "<string rarity>",
	description = "Spawn a random item spawner",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, rarity)
		local category = argtoenum[rarity or "common"];
		
		if !category then
			return false, "Invalid category"
		end

		local spawner = ents.Create("loot_spawner")
		spawner:SetPos(ply:GetEyeTraceNoCursor().HitPos)
		spawner:SetLootCategory(category)
		spawner:Spawn()

		hook.Run("SaveLootSpawns")
		
		GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " created loot spawner with category \"" .. rarity .. "\"", ply)
	end,
})