kingston.admin.registerCommand("ranktakeperm", {
	syntax = "<string uniqueID> <list[string] permissions>",
	description = "Take a rank's command permissions",
	arguments = {ARGTYPE_STRING, bit.bor(ARGTYPE_STRING, ARGTYPE_ARRAY)},
	onRun = function(ply, uniqueID, permissions)
		local group = kingston.admin.getGroup(uniqueID)
		if !group then
			return false, "group does not exist"
		end

		for _,permission in pairs(permissions) do
			if !group.permissions[permission] then continue end

			group:takePermission(permission)
		end

		ply:Notify(nil, COLOR_NOTIF, "Group permissions updated successfully.")
	end,
})