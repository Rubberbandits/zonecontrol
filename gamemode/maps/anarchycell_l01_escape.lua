function GM:GetHL2CamPos()
	
	return { Vector( -5049.085938, -10670.820313, 297.100403 ), Angle( 11.830449, -132.702927, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector(1497, 14991, -47), LOCATION_ROSTOK, 200, TRANSITPORT_CROSSROADS_ROSTOK );
	--self:CreateLocationPoint( Vector(-13645, -9643, -212), LOCATION_SWAMP, 200, TRANSITPORT_CROSSROADS_SWAMP );

end

GM.EnableAreaportals = true;

GM.DefaultSpawnLocation = Vector(-2636, -6591, 588)

GM.CurrentLocation = LOCATION_CROSSROADS;
