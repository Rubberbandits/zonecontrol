local meta = FindMetaTable( "Player" );

function meta:GoToServer( location, port )
	
	self:UpdateCharacterField( "Location", location );
	self:UpdateCharacterField( "EntryPort", port );
	
	local server = "";
	if( location == LOCATION_CITY ) then
		
		server = IP_GENERAL .. ":" .. PORT_CITY;
		
	elseif( location == LOCATION_CANAL ) then
		
		server = IP_GENERAL .. ":" .. PORT_CANAL;
		
	elseif( location == LOCATION_OUTLANDS ) then
		
		server = IP_GENERAL .. ":" .. PORT_OUTLANDS;
		
	elseif( location == LOCATION_COAST ) then
		
		server = IP_GENERAL .. ":" .. PORT_COAST;
		
	end
		
	netstream.Start( self, "nConnect", server );
	
end

function GM:CreateLocationPoint( pos, loc, rad, port, cp )
	
	local c = ents.Create( "cc_server" );
	c:SetPos( pos );
	c:Spawn();
	c:Activate();
	c.Location = loc;
	c.Port = port;
	c.Radius = rad or 256;
	c.CP = cp;
	
end

function nServerOfferAccept( ply, loc, port )

	local good = false;
	
	for _, v in pairs( ents.FindByClass( "cc_server" ) ) do
		
		if( v.Location == loc and v:GetPos():Distance( ply:GetPos() ) <= 256 ) then
			
			good = true;
			break;
			
		end
		
	end
	
	if( !good ) then return end
	
	ply:GoToServer( loc, port );
	
end
netstream.Hook( "nServerOfferAccept", nServerOfferAccept );