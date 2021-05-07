function GM:GetHL2CamPos()
	
	return { Vector( 6209.778320, -7237.353516, 286.663116 ), Angle( 14.123675, 113.543312, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector(1832.619141, 11233.148438, -183.165222), LOCATION_JUPITER, 200, TRANSITPORT_ARMYWAREHOUSES_JUPITER );

end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_ARMYWAREHOUSES_JUPITER] = "Continuing down this road takes you to Yanov, now considered one of the most northern points that STALKERs have travelled in the Zone.";

GM.EntryPortSpawns[TRANSITPORT_JUPITER_ARMYWAREHOUSES] = {
	Vector(2257.588623, 10841.069336, -255.841766),
	Vector(2193.104248, 10815.973633, -254.833862),
	Vector(2215.409912, 10752.694336, -265.591919),
	Vector(2299.117676, 10780.451172, -267.209686),
	Vector(2336.875244, 10700.021484, -282.158051),
	Vector(2264.537354, 10666.298828, -287.079620),
	Vector(2287.517578, 10596.134766, -299.896210),
	Vector(2363.249268, 10621.324219, -297.712708),
};

--GM.DefaultSpawnLocation = Vector(-1485, -11828, -412)

GM.CurrentLocation = LOCATION_ARMYWAREHOUSES;
