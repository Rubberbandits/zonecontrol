local function SeeAllProps( ply, args )
	
	netstream.Start( ply, "nASeeAllProps" );
	
end
concommand.AddAdmin( "rpa_seeallprops", SeeAllProps );