kingston.admin.registerCommand("plynotesadd", {
	syntax = "<string target> <string note>",
	description = "Add an admin note to a player",
	arguments = {bit.bor(ARGTYPE_TARGET, ARGTYPE_STEAMID), ARGTYPE_STRING},
	onRun = function(ply, target, note)
		if isentity(target) then
			target = target:SteamID()
		end

		function kingston.admin.notes.create:onSuccess(data)
			ply:Notify(nil, COLOR_NOTIF, "Note successfully added.")
		end

		kingston.admin.notes.create:clearParameters()
			kingston.admin.notes.create:setString(1, target)
			kingston.admin.notes.create:setString(2, note)
			kingston.admin.notes.create:setString(3, ply:Nick())
		kingston.admin.notes.create:start()
	end,
})