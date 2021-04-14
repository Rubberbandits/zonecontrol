function GM:GetHL2CamPos()
	
	return { Vector( -6854.933594, -6655.150879, 729.411011 ), Angle( 20.922195, 0.427214, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( -1679.909180, 14224.734375, 900.020752 ), LOCATION_GARBAGE, 200, TRANSITPORT_CORDON_GARBAGE );
	--self:CreateLocationPoint( Vector( 8672, -1084, 649 ), LOCATION_DARKSCAPE, 200, TRANSITPORT_CORDON_DARKSCAPE );
	--self:CreateLocationPoint( Vector( -7395, -10341, 403 ), LOCATION_GREATSWAMP, 200, TRANSITPORT_CORDON_SWAMP );

end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_CORDON_GARBAGE] = "Continuing down this road takes you to the Garbage, an area of forgotten treasures and heaps of trash.";
GM.ConnectMessages[TRANSITPORT_CORDON_DARKSCAPE] = "Continuing down this road takes you to Darkscape, a barren highway with dangerous creatures and a helping dash of bandits.";
GM.ConnectMessages[TRANSITPORT_CORDON_SWAMP] = "Continuing down this road takes you to the Great Swamps, lush with vegetation, anomalies and bandits alike.";


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
GM.EntryPortSpawns[TRANSITPORT_DARKSCAPE_CORDON] = {
	Vector( 7672, -1295, 671 ),
	Vector( 7664, -1227, 671 ),
	Vector( 7719, -1221, 672 ),
	Vector( 7728, -1297, 672 ),
	Vector( 7780, -1291, 673 ),
	Vector( 7773, -1223, 672 ),
	Vector( 7765, -1152, 672 ), 
	Vector( 7795, -1105, 672 ),
};
GM.EntryPortSpawns[TRANSITPORT_SWAMP_CORDON] = {
	Vector( -6845, -10281, 408 ),
	Vector( -6850, -10377, 402 ),
	Vector( -6918, -10374, 402 ),
	Vector( -6954, -10315, 403 ), 
	Vector( -7076, -10383, 403 ), 
	Vector( -7151, -10380, 403 ),
}

GM.CurrentLocation = LOCATION_CORDON;