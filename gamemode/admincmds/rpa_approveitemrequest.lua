local function ApproveItemRequest(ply, args)
	if #args == 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: no id specified.")
		return
	end
	
	local request = kingston.item.item_requests[tonumber(args[1])]
	if request then
		kingston.item.approve_gm_item(tonumber(args[1]))
		kingston.log.write("admin", "[%s (%s)(%s)] approved %s's request for %s.", ply:RPName(), ply:Nick(), ply:SteamID(), request.requester:Nick(), request.class)
	else
		ply:Notify(nil, COLOR_ERROR, "Error: invalid id specified.")
	end
end
concommand.AddAdmin("rpa_approveitemrequest", ApproveItemRequest)