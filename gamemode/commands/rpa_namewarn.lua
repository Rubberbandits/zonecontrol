

kingston.admin.registerCommand("charnamewarn", {
	syntax = "<string target>",
	description = "Warn a player for their character's name",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		netstream.Start( target, "nWarnName" );
	end,
})