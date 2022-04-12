local GROUP_SETSA		= 5

kingston.admin.registerCommand("ranksetsuperadmin", {
	syntax = "<string uniqueID> <bool isSuperAdmin>",
	description = "Whether or not a rank is considered a \"superadmin\"",
	arguments = {ARGTYPE_STRING, ARGTYPE_BOOL},
	onRun = function(ply, uniqueID, isAdmin)
		local group = kingston.admin.getGroup(uniqueID)
		if !group then
			return false, "group does not exist"
		end

		group.isSuperAdmin = isAdmin

		kingston.admin.queries.modifySuperAdmin:clearParameters()
			kingston.admin.queries.modifySuperAdmin:setNumber(1, isAdmin and 1 or 0)
			kingston.admin.queries.modifySuperAdmin:setString(2, uniqueID)
		kingston.admin.queries.modifySuperAdmin:start()

		net.Start("zcUpdateGroup")
			net.WriteString(uniqueID)
			net.WriteUInt(GROUP_SETSA, 8)
			net.WriteBool(isAdmin)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "Group isSuperAdmin updated successfully.")
	end,
})