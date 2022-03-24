

kingston.admin.registerCommand("chargivestockpile", {
	syntax = "<string target>",
	description = "Allow a character to create their own stockpile",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		target.StartStockpileCreation = true;
		netstream.Start( target, "nRequestStockpileName" );
	end,
})