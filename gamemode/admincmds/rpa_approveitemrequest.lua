

kingston.admin.registerCommand("approveitemrequest", {
	syntax = "<number requestID>",
	description = "Approve a pending item request",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, requestID)
		local request = kingston.item.item_requests[requestID]
		if request then
			kingston.item.approve_gm_item(requestID)
			kingston.log.write("admin", "[%s (%s)(%s)] approved %s's request for %s.", ply:RPName(), ply:Nick(), ply:SteamID(), request.requester:Nick(), request.class)
		else
			return false, "invalid id specified"
		end
	end,
})