kingston.admin.registerCommand("charban", {
	syntax = "<string target>",
	description = "Ban a character from being played.",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		target:UpdateCharacterField("Banned", "1");
		target:Notify(nil, COLOR_NOTIF, "Your character has been permanently killed.");

		target:UnloadCharacter()
		
		GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " permanently killed " .. target:RPName() .. ".", ply );
	end,
})