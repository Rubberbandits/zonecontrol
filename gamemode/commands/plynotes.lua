kingston.admin.registerCommand("plynotes", {
	syntax = "<string target>",
	description = "View admin notes on a player",
	arguments = {bit.bor(ARGTYPE_TARGET, ARGTYPE_STEAMID)},
	onRun = function(ply, target)
		if isentity(target) then
			target = target:SteamID()
		end

		function kingston.admin.notes.get:onSuccess(data)
			if #data == 0 then
				ply:Notify(nil, COLOR_NOTIF, "This player has no active notes.")
				return
			end
			
			local message = "Notes on this player:\n\t"
			local notes = {}

			for _,noteData in pairs(data) do
				table.insert(notes, Format("[%s, ID #%d] (%s) %s", noteData.Date, noteData.id, noteData.AddedBy, noteData.Message))
			end

			ply:Notify(nil, COLOR_NOTIF, "Notes on this player:\n%s", table.concat(notes, "\n"))
		end

		kingston.admin.notes.get:clearParameters()
			kingston.admin.notes.get:setString(1, target)
		kingston.admin.notes.get:start()
	end,
})

if SERVER then
	kingston = kingston or {}
	kingston.admin = kingston.admin or {}
	kingston.admin.notes = kingston.admin.notes or {}

	// create notes db table and queries
	local db_notes_tbl = {
		{ "Date", "TIMESTAMP" },
		{ "SteamID", "VARCHAR(20)" },
		{ "AddedBy", "VARCHAR(20)" },
		{ "Message", "VARCHAR(4096)" }
	}

	local function init_notes_tbl(db)
		mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_player_notes ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
		GAMEMODE:InitSQLTable(db_notes_tbl, "cc_player_notes")

		kingston.admin.notes.create = db:prepare("INSERT INTO `cc_player_notes` (`Date`, `SteamID`, `Message`, `AddedBy`) VALUES (CURRENT_TIMESTAMP(), ?, ?, ?);")
		kingston.admin.notes.delete = db:prepare("DELETE FROM `cc_player_notes` WHERE `id` = ?;")
		kingston.admin.notes.get = db:prepare("SELECT `id`, `Date`, `Message`, `AddedBy` FROM `cc_player_notes` WHERE `SteamID` = ?;")
	end
	hook.Add("InitSQLTables", "STALKER.InitNotesDBTable", init_notes_tbl)
end