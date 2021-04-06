function GM:GetHL2CamPos()
	
	return { Vector( -6854.933594, -6655.150879, 729.411011 ), Angle( 20.922195, 0.427214, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( 1755.397095, -12685.960938, 193.626816 ), LOCATION_CORDON, 200, TRANSITPORT_GARBAGE_CORDON );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_GARBAGE_CORDON] = "Continuing down this road takes you to the Cordon, an area commonly known for it's rookies and military slackjaws.";

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

GM.CurrentLocation = LOCATION_GARBAGE;