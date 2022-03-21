kingston.admin.registerCommand("seeall", {
	syntax = "<none>",
	description = "Activate SeeAll",
	arguments = {},
	onRun = function(ply)
		netstream.Start( ply, "nASeeAll" );
		ply.UsingSeeAll = !ply.UsingSeeAll
	end,
})