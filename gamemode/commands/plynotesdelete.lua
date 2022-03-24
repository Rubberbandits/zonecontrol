kingston.admin.registerCommand("plynotesdelete", {
	syntax = "<number noteID>",
	description = "Remove an admin note from a player",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, noteID)
		function kingston.admin.notes.delete:onSuccess(data)
			ply:Notify(nil, COLOR_NOTIF, "Note successfully deleted.")
		end

		kingston.admin.notes.delete:clearParameters()
			kingston.admin.notes.delete:setNumber(1, noteID)
		kingston.admin.notes.delete:start()
	end,
})