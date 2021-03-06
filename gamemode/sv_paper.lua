function nWritePaper( ply, val )
	
	if( string.len( val ) <= 2000 ) then
		local paper = ply:HasItem( "paper" )
		if( paper ) then
			
			paper:RemoveItem(true)
			
			local trace = { };
			trace.start = ply:GetShootPos();
			trace.endpos = trace.start + ply:GetAimVector() * 50;
			trace.filter = ply;
			
			local tr = util.TraceLine( trace );
			
			local pos = tr.HitPos + tr.HitNormal * 10;
			
			local ent = ents.Create( "cc_paper" );
			ent:SetPos( pos );
			ent:SetAngles( ply:GetAngles() );
			ent:SetText( val );
			ent:Spawn();
			ent:Activate();
			
			ent:SetPropSteamID( ply:SteamID() );
			
		end
		
	end
	
end
netstream.Hook( "nWritePaper", nWritePaper );
