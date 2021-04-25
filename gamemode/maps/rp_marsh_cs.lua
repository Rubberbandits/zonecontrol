Vector(-3904, 12247, 344)

function GM:GetHL2CamPos()
	
	return { Vector( -1030.898315, 6903.635254, 652.910095 ), Angle( 17.901625, -41.429134, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector(-3904, 12247, 344), LOCATION_CROSSROADS, 200, TRANSITPORT_SWAMP_CROSSROADS );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_SWAMP_CROSSROADS] = "Continuing down this road takes you to the Crossroads, a point in the center of the Zone that connects some of the most dangerous areas to the more civilized parts."

GM.EntryPortSpawns[TRANSITPORT_CROSSROADS_SWAMP] = {
	Vector(-3181, 12247, 344),
	Vector(-3193, 12335, 338),
	Vector(-3264, 12336, 338),
	Vector(-3265, 12247, 344),
	Vector(-3325, 12246, 344),
	Vector(-3328, 12317, 342),
	Vector(-3327, 12149, 338),
	Vector(-3263, 12150, 338),
};

GM.DefaultSpawnLocation = Vector(-2785, 8620, 64)

GM.CurrentLocation = LOCATION_SWAMP;