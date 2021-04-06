local function SetRank(ply, args)
	if #args == 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return
	end
	
	local targ = GAMEMODE:FindPlayer(args[1], ply)
	local rank = args[2] or "user"
	
	if targ and targ:IsValid() then
		targ:SetUserGroup(rank)
		targ:UpdatePlayerField("Rank", rank)
		
		GAMEMODE:Notify({ply, targ}, nil, COLOR_NOTIF, "%s set %s's rank to %s.", ply:Nick(), targ:Nick(), rank)
	else
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
	end
end
concommand.AddAdmin("rpa_setrank", SetRank, true)