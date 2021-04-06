local function Seeall( ply, args )
	
	netstream.Start( ply, "nASeeAll" );
	ply.UsingSeeAll = !ply.UsingSeeAll
	
end
concommand.AddAdmin( "rpa_seeall", Seeall );
