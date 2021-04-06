local function DenyItemRequest(ply, args)
	if #args == 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: no id specified.")
		return
	end
	
	local request = kingston.item.item_requests[tonumber(args[1])]
	if request then
		netstream.Start({ply, request.requester}, "nAddNotification", Format("Player %s's request for item %s was denied.", request.requester:Nick(), request.class))
		kingston.item.item_requests[tonumber(args[1])] = nil
	else
		ply:Notify(nil, COLOR_ERROR, "Error: invalid id specified.")
	end
end
concommand.AddAdmin("rpa_denyitemrequest", DenyItemRequest)