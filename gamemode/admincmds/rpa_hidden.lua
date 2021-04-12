local function Hidden( ply, args )
	
	if( args[1] and tonumber( args[1] ) and ( tonumber( args[1] ) == 0 or tonumber( args[1] ) == 1 ) ) then
		
		ply:SetHidden( tonumber( args[1] ) == 1 );
		
	else
		
		ply:SetHidden( !ply:Hidden() );
		
	end
	
end
concommand.AddAdmin( "rpa_hidden", Hidden );