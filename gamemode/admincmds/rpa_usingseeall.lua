local function UsingSeeAll( ply, args )
	local tbl = {}
	for k,v in next, player.GetAll() do
		if v.UsingSeeAll then
			tbl[k] = v
		end
	end
	
	netstream.Start(ply, "nPrintUsingSeeAll", tbl)
end
concommand.AddAdmin( "rpa_usingseeall", UsingSeeAll );