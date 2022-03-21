

kingston.admin.registerCommand("flagsroster", {
	syntax = "<none>",
	description = "View all characters with flags",
	arguments = {},
	onRun = function(ply)
		local function qS(ret)	
			netstream.Start(ply, "nAFlagsRoster", ret)
			
			GAMEMODE:LogSQL("Player " .. ply:Nick() .. " retrieved flags roster.")
		end
		
		local function qF(err) end
		
		mysqloo.Query("SELECT RPName, CharFlags FROM cc_chars WHERE CharFlags != ''", qS, qF)
	end,
})