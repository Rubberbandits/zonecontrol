kingston.admin.registerCommand("factionspawnremove", {
	syntax = "<string patch_class>",
	description = "Removes a faction's spawn point.",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, patch)
		local metaitem = GAMEMODE:GetItemByID(patch)
		if !metaitem or metaitem.Base != "patch" then
			return false, "invalid patch"
		end

		kingston.factions.spawns[patch] = nil
		hook.Run("SaveFactions")
		
		GAMEMODE:LogAdmin(Format("[B] %s removed spawn point for %s.", ply:Nick(), patch), ply)
	end,
})