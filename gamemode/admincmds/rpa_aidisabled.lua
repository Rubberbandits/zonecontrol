local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

kingston.admin.registerCommand("aidisabled", {
	syntax = "<number enabled>",
	description = "Disable/enable NPC AI",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, number)
		RunConsoleCommand( "ai_disabled", number );
	end,
})