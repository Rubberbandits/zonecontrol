kingston.admin.registerCommand("factionspawnset", {
	syntax = "<string patch_class>",
	description = "Set a faction's spawn point depending on the patch they wear. Spawn position is where you are standing when you run this command.",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, patch)
		local metaitem = GAMEMODE:GetItemByID(patch)
		if !metaitem or metaitem.Base != "patch" then
			return false, "invalid patch"
		end

		kingston.factions.spawns[patch] = ply:GetPos()
		hook.Run("SaveFactions")
		
		GAMEMODE:LogAdmin(Format("[B] %s set spawn point for %s", ply:Nick(), patch), ply)
	end,
})