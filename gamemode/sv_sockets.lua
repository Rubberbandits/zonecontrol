local meta = FindMetaTable( "Player" );

local ServerLocations = {
	[LOCATION_CORDON] = IP_GENERAL .. ":" .. PORT_CORDON,
	[LOCATION_GARBAGE] = IP_GENERAL .. ":" .. PORT_GARBAGE,
	[LOCATION_RASPAD] = IP_GENERAL .. ":" .. PORT_RASPAD,
	[LOCATION_AGROPROM] = IP_GENERAL .. ":" .. PORT_AGROPROM,
	[LOCATION_DARKVALLEY] = IP_GENERAL .. ":" .. PORT_DARKVALLEY,
	[LOCATION_ROSTOK] = IP_GENERAL .. ":" .. PORT_ROSTOK,
}

function meta:GoToServer( location, port )
	
	self:UpdateCharacterField( "Location", location );
	self:UpdateCharacterField( "EntryPort", port );
	
	local server = ServerLocations[location] or "";
	print(server)
		
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

local function nServerOfferAccept( ply, loc, port )

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