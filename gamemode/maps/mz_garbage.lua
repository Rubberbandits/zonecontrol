function GM:GetHL2CamPos()
	
	return { Vector( -6854.933594, -6655.150879, 729.411011 ), Angle( 20.922195, 0.427214, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector( 1755.397095, -12685.960938, 193.626816 ), LOCATION_CORDON, 200, TRANSITPORT_GARBAGE_CORDON );
	--self:CreateLocationPoint( Vector( 55.021484, 9859.971680, 220.937317 ), LOCATION_ROSTOK, 200, TRANSITPORT_GARBAGE_ROSTOK );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_GARBAGE_CORDON] = "Continuing down this road takes you to the Cordon, an area commonly known for it's rookies and military slackjaws.";
GM.ConnectMessages[TRANSITPORT_GARBAGE_ROSTOK] = "Continuing down this road takes you to Rostok, the location of the famous 100 Rads Bar, though newly controlled by Freedom.";

GM.EntryPortSpawns[TRANSITPORT_CORDON_GARBAGE] = {
	Vector(1608.839233, -12334.611328, 216.446747),
	Vector(1819.337036, -12324.716797, 213.186066),
	Vector(1870.151489, -12499.400391, 204.921341),
	Vector(1626.256348, -12474.920898, 213.087021),
	Vector(1600.141357, -12578.291016, 208.219437),
	Vector(1773.136475, -12620.375977, 198.599854),
	Vector(1757.656128, -12708.585938, 191.346298),
	Vector(1629.866577, -12678.833008, 200.705566),
};

GM.EntryPortSpawns[TRANSITPORT_ROSTOK_GARBAGE] = {
	Vector(1445.032837, 9216.371094, 104.419571),
	Vector(1335.551392, 9108.293945, 101.640785),
	Vector(1387.791992, 9052.094727, 110.948853),
	Vector(1451.768677, 9109.283203, 114.272827),
	Vector(1489.575562, 9077.723633, 116.636711),
	Vector(1439.014038, 9019.850586, 118.507050),
	Vector(1481.994507, 8970.337891, 119.803703),
	Vector(1575.871826, 9021.904297, 118.949097),
}

GM.CurrentLocation = LOCATION_GARBAGE;