local GROUP_PRIORITY 	= 2

kingston.admin.registerCommand("ranksetpriority", {
	syntax = "<string uniqueID> <number priority>",
	description = "Sets a rank's priority over other ranks",
	arguments = {ARGTYPE_STRING, ARGTYPE_NUMBER},
	onRun = function(ply, uniqueID, priority)
		local group = kingston.admin.getGroup(uniqueID)
		if !group then
			return false, "group does not exist"
		end

		group.priority = priority

		kingston.admin.queries.modifyPriority:clearParameters()
			kingston.admin.queries.modifyPriority:setNumber(1, priority)
			kingston.admin.queries.modifyPriority:setString(2, uniqueID)
		kingston.admin.queries.modifyPriority:start()

		net.Start("zcUpdateGroup")
			net.WriteString(uniqueID)
			net.WriteUInt(GROUP_PRIORITY, 8)
			net.WriteUInt(priority, 8)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "Group isAdmin updated successfully.")
	end,
})