function GM:GetHL2CamPos()
	
	return { Vector( -569.726501, 4441.151367, -205.591888 ), Angle( 22.027716, 65.164886, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector(13454.710938, 13815.968750, -848.968750), LOCATION_ARMYWAREHOUSES, 200, TRANSITPORT_JUPITER_ARMYWAREHOUSES );

end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_JUPITER_ARMYWAREHOUSES] = "Continuing down this road takes you to the Army Warehouses, the location of the former base of Freedom and the way to the North.";

GM.EntryPortSpawns[TRANSITPORT_ARMYWAREHOUSES_JUPITER] = {
	Vector(13548.268555, 13375.601563, -848.968750),
	Vector(13407.326172, 13386.547852, -848.968750),
	Vector(13398.931641, 13278.756836, -848.968750),
	Vector(13532.133789, 13245.562500, -848.968750),
	Vector(13522.356445, 13120.030273, -848.968750),
	Vector(13404.665039, 13126.837891, -848.968750),
	Vector(13401.224609, 12994.112305, -848.968750),
	Vector(13510.527344, 12960.833008, -848.968750),
};

--GM.DefaultSpawnLocation = Vector(-1485, -11828, -412)

GM.CurrentLocation = LOCATION_JUPITER;
