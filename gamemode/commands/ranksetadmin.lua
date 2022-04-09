local GROUP_SETADMIN	= 4

kingston.admin.registerCommand("ranksetadmin", {
	syntax = "<string uniqueID> <bool isAdmin>",
	description = "Whether or not a rank is considered an \"admin\"",
	arguments = {ARGTYPE_STRING, ARGTYPE_BOOL},
	onRun = function(ply, uniqueID, isAdmin)
		local group = kingston.admin.getGroup(uniqueID)
		if !group then
			return false, "group does not exist"
		end

		group.isAdmin = isAdmin

		kingston.admin.queries.modifyAdmin:clearParameters()
			kingston.admin.queries.modifyAdmin:setNumber(1, isAdmin and 1 or 0)
			kingston.admin.queries.modifyAdmin:setString(2, uniqueID)
		kingston.admin.queries.modifyAdmin:start()

		net.Start("zcUpdateGroup")
			net.WriteString(uniqueID)
			net.WriteUInt(GROUP_SETADMIN, 8)
			net.WriteBool(isAdmin)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "Group isAdmin updated successfully.")
	end,
})