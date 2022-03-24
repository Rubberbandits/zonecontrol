kingston.admin.registerCommand("usingseeall", {
	syntax = "<none>",
	description = "Print a list of all admins using seeall",
	arguments = {},
	onRun = function(ply, target)
		local tbl = {}
		for k,v in next, player.GetAll() do
			if v.UsingSeeAll then
				tbl[k] = v
			end
		end
		
		netstream.Start(ply, "nPrintUsingSeeAll", tbl)
	end
})