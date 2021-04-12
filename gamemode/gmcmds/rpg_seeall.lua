local function Seeall( ply, args )
	
	netstream.Start( ply, "nASeeAll" );
	ply.UsingSeeAll = !ply.UsingSeeAll
	
end
concommand.AddGamemaster( "rpg_seeall", Seeall );