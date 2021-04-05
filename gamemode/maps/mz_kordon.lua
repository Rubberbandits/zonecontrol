function GM:GetHL2CamPos()
	
	return { Vector( -6854.933594, -6655.150879, 729.411011 ), Angle( 20.922195, 0.427214, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( -1679.909180, 14224.734375, 900.020752 ), LOCATION_GARBAGE, 200, TRANSITPORT_CORDON_GARBAGE );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_CORDON_GARBAGE] = "Continuing down this road takes you to the Garbage, an area of forgotten treasures and heaps of trash.";

GM.EntryPortSpawns[TRANSITPORT_GARBAGE_CORDON] = {
	Vector( -1652, 13786, 900 ),
	Vector( -1790.216797, 13777.437500, 900.031189 ),
	Vector( -1782.720215, 13699.675781, 900.031189 ),
	Vector( -1648.792725, 13691.421875, 900.031189 ),
	Vector( -1651.958374, 13616.722656, 900.031189 ),
	Vector( -1740.687988, 13618.744141, 900.031189 ),
	Vector( -1748.483154, 13560.226563, 900.031189 ),
	Vector( -1656.728760, 13554.570313, 900.031189 ),
};

GM.CurrentLocation = LOCATION_CORDON;