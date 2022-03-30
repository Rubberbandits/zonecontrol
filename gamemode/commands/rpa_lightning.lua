if StormFox2 then
	local ARGTYPE_TARGET 	= 0
	local ARGTYPE_STRING 	= 1
	local ARGTYPE_BOOL 		= 2
	local ARGTYPE_NUMBER 	= 3

	kingston.admin.registerCommand("plylightning", {
		syntax = "<string target>",
		description = "Zeus strike a player",
		arguments = {ARGTYPE_TARGET},
		onRun = function(ply, target)
			StormFox2.Thunder.Strike(target)

			GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " lighnting'd player " .. target:Nick() .. ".", ply );

			target:Notify(nil, COLOR_NOTIF, Format("%s used zeus lightning on you.", ply:Nick()))
		end,
	})
end