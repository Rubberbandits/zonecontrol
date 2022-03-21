kingston.admin.registerCommand("setcharflag", {
	syntax = "<string target> <string flags>",
	description = "Set a character's flags",
	arguments = {ARGTYPE_TARGET, bit.bor(ARGTYPE_STRING, ARGTYPE_NONE)},
	onRun = function(ply, target, flags)
		if flags == NULL then
			flags = ""
		end

		local old_flags = target:CharFlags()
		target:SetCharFlags( flags );
		
		for i=1, #flags do
			local flag = flags[i]
			if !old_flags:find(flag) then
				local new_flag = GAMEMODE.CharFlags[flag]
				if new_flag and new_flag.OnGiven then
					new_flag.OnGiven( target );
				end
			end
		end
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. target:RPName() .. "'s character flag to \"" .. flags .. "\".", ply );
		
		local rf = { ply, target };
		
		if( flags == "" ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed all of %s's flags.", ply:Nick(), target:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's flags to \"%s\"", ply:Nick(), target:Nick(), flags)
			
		end
		
		target:UpdateCharacterField( "CharFlags", flags );
	end,
})