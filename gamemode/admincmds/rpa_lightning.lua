if StormFox2 then
	local function ZeusStrike( ply, args )

		local targ = args[1] and GAMEMODE:FindPlayer(args[1], ply) or ply:GetEyeTraceNoCursor().HitPos

		StormFox2.Thunder.Strike(targ)

		if isentity(targ) then
			GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " lighnting'd player " .. targ:Nick() .. ".", ply );

			targ:Notify(nil, COLOR_NOTIF, "%s used zeus lightning on you.", ply:Nick())
		end
		
	end
	concommand.AddAdmin( "rpa_lightning", ZeusStrike );
end