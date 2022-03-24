

kingston.admin.registerCommand("gameaidisabled", {
	syntax = "<number enabled>",
	description = "Disable/enable NPC AI",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, number)
		RunConsoleCommand( "ai_disabled", number );
	end,
})