

kingston.admin.registerCommand("plyhidden", {
	syntax = "<bool hidden>",
	description = "Hide yourself from the scoreboard",
	arguments = {ARGTYPE_BOOL},
	onRun = function(ply, hidden)
		ply:SetHidden(hidden);
	end,
})