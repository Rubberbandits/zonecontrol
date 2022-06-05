kingston.admin.registerCommand("gamestopurl", {
	syntax = "<number index>",
	description = "Stop playing sounds by index",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, index)
		net.Start("zcStopSound")
			net.WriteUInt(index, 8)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "Sound stopped for all players.")
	end,
})
