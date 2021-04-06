local function HideAdmin( ply, args )
	
	if( args[1] and tonumber( args[1] ) and ( tonumber( args[1] ) == 0 or tonumber( args[1] ) == 1 ) ) then
		
		ply:SetHideAdmin( tonumber( args[1] ) == 1 );
		
	else
		
		ply:SetHideAdmin( !ply:HideAdmin() );
		
	end
	
end
concommand.AddAdmin( "rpa_hideadmin", HideAdmin );