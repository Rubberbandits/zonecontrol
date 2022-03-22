kingston.admin.registerCommand("togglewatched", {
	syntax = "<string target>",
	description = "Toggle whether or not a target is watched by the big brother system",
	arguments = {},
	onRun = function(ply, target)
		target:SetWatched(!target:Watched())
		target:UpdatePlayerField( "Watched", target:Watched() and "1" or "0" )
		ply:Notify(nil, COLOR_NOTIF, target:Watched() and "%s is now being watched." or "%s is no longer being watched.", target:Nick())
	end
})