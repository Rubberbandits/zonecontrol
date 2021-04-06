local function FlagsRoster( ply, args )
	
	local function qS( ret )
		
		netstream.Start( ply, "nAFlagsRoster", ret );
		
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved flags roster." );
		
	end
	
	local function qF( err )
		
	end
	
	mysqloo.Query( "SELECT RPName, CharFlags FROM cc_chars WHERE CharFlags != ''", qS, qF );
	
end
concommand.AddAdmin( "rpa_flagsroster", FlagsRoster );