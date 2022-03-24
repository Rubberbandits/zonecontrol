

kingston.admin.registerCommand("plyhideadmin", {
	syntax = "<bool hidden>",
	description = "Hide your admin badge from the scoreboard",
	arguments = {ARGTYPE_BOOL},
	onRun = function(ply, hidden)
		ply:SetHideAdmin( hidden );
	end,
})