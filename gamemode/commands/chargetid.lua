kingston.admin.registerCommand("chargetid", {
	syntax = "<string target>",
	description = "Get a character's ID.",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		ply:Notify(nil, COLOR_NOTIF, "This character's ID is %d", target:CharID())
	end,
})