kingston.admin.registerCommand("rankdelete", {
	syntax = "<string uniqueID>",
	description = "Delete a rank",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, uniqueID)
		local group = kingston.admin.getGroup(uniqueID)
		if !group then
			return false, "group does not exist"
		end

		group:delete()

		ply:Notify(nil, COLOR_NOTIF, "Group deleted successfully.")
	end,
})