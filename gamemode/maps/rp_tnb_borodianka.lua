function GM:GetHL2CamPos()
	
	return { Vector( -3314.973633, 35.648899, 328.775238 ), Angle( 14.322018, 35.663460, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector( -13051.937500, -8850.031250, 118.061867 ), LOCATION_GARBAGE, 200, TRANSITPORT_ROSTOK_GARBAGE );
	--self:CreateLocationPoint( Vector( -3113.026611, -12049.968750, 64.031250 ), LOCATION_TRUCKCEMETERY, 200, TRANSITPORT_ROSTOK_TRUCKCEMETERY );
	--self:CreateLocationPoint( Vector( -6636.538574, -1984.968750, -259.968750 ), LOCATION_CROSSROADS, 200, TRANSITPORT_ROSTOK_CROSSROADS );
	
end

GM.EnableAreaportals = true;

GM.DefaultSpawnLocation = Vector(-1254.419189, 612.415039, 136.03125)

GM.CurrentLocation = LOCATION_OUTSIDE_ZONE;
