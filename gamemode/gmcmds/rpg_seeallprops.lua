local function SeeAllProps( ply, args )
	
	netstream.Start( ply, "nASeeAllProps" );
	
end
concommand.AddGamemaster( "rpg_seeallprops", SeeAllProps );