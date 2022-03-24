kingston.admin.registerCommand("adminseeallprops", {
	syntax = "<none>",
	description = "Activate perma-prop outlines in SeeAll",
	arguments = {},
	onRun = function(ply)
		netstream.Start( ply, "nASeeAllProps" );
	end,
})