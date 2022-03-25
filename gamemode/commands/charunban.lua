kingston.admin.registerCommand("charunban", {
	syntax = "<number charID>",
	description = "Unban a character, allowing it to be played again.",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, charID)
		GAMEMODE:UpdateCharacterFieldOffline(charID, "Banned", "0")
		GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " lifted the character ban on charID #" .. charID .. ".", ply );
	end,
})