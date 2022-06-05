kingston.admin.registerCommand("gamestopurl", {
	syntax = "<number index [optional]>",
	description = "Stop playing sounds by index or all currently playing URLs",
	arguments = {bit.bor(ARGTYPE_NUMBER, ARGTYPE_NONE)},
	onRun = function(ply, index)
		net.Start("zcStopSound")
			net.WriteUInt(url, 8)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "Sound stopped for all players.")
	end,
})
