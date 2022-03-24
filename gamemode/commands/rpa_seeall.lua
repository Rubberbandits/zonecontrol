kingston.admin.registerCommand("adminseeall", {
	syntax = "<none>",
	description = "Activate SeeAll",
	arguments = {},
	onRun = function(ply)
		netstream.Start( ply, "nASeeAll" );
		ply.UsingSeeAll = !ply.UsingSeeAll
	end,
})