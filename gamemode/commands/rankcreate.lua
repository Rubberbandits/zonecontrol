kingston.admin.registerCommand("rankcreate", {
	syntax = "<string uniqueID> <number priority> <bool isAdmin> <bool isSuperAdmin> <string charFlag>",
	description = "Create a new rank and give it permissions",
	arguments = {ARGTYPE_STRING, ARGTYPE_NUMBER, ARGTYPE_BOOL, ARGTYPE_BOOL, ARGTYPE_STRING},
	onRun = function(ply, uniqueID, priority, isAdmin, isSuperAdmin, charFlag)
		local existing = kingston.admin.getGroup(uniqueID)
		if existing then
			return false, "Group with this uniqueID already exists"
		end

		local newGroup = kingston.admin.createGroup(uniqueID, {
			priority = priority,
			isAdmin = isAdmin,
			isSuperAdmin = isSuperAdmin,
			charFlag = charFlag
		})

		if !newGroup then
			return false, "group creation failed (contact dev)"
		end

		ply:Notify(nil, COLOR_NOTIF, "Group created successfully.")
	end,
})