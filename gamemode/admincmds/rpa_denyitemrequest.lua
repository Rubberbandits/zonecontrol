

kingston.admin.registerCommand("denyitemrequest", {
	syntax = "<number requestID>",
	description = "Deny an item request",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, requestID)
		local request = kingston.item.item_requests[requestID]
		if !request then
			return false, "invalid item request"
		end

		netstream.Start({ply, request.requester}, "nAddNotification", Format("Player %s's request for item %s was denied.", request.requester:Nick(), request.class))
		kingston.item.item_requests[requestID] = nil
	end,
})