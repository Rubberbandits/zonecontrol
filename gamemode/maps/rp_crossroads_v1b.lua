function GM:GetHL2CamPos()
	
	return { Vector( -5049.085938, -10670.820313, 297.100403 ), Angle( 11.830449, -132.702927, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector(1497, 14991, -47), LOCATION_ROSTOK, 200, TRANSITPORT_CROSSROADS_ROSTOK );
	--self:CreateLocationPoint( Vector(-13645, -9643, -212), LOCATION_SWAMP, 200, TRANSITPORT_CROSSROADS_SWAMP );

end

GM.EnableAreaportals = true;

hook.Add("OnGamemodeLoaded", "DefineTransitions", function()
	local gm = gmod.GetGamemode()
	gm.ConnectMessages[TRANSITPORT_CROSSROADS_ROSTOK] = "Continuing down this road takes you to Rostok, the location of the famous 100 Rads Bar, though newly controlled by Freedom.";
	gm.ConnectMessages[TRANSITPORT_CROSSROADS_SWAMP] = "Continuing down this road takes you to the Great Swamp, an once-inaccessible area roamed by many types of creatures."

	gm.EntryPortSpawns[TRANSITPORT_ROSTOK_CROSSROADS] = {
		Vector(-13155, -9522, -272),
		Vector(-13149, -9640, -269),
		Vector(-13053, -9640, -276),
		Vector(-13035, -9540, -279),
		Vector(-12940, -9537, -283),
		Vector(-12933, -9647, -285),
		Vector(-12825, -9648, -290),
		Vector(-12805, -9540, -288),
	};
	gm.EntryPortSpawns[TRANSITPORT_SWAMP_CROSSROADS] = {
		Vector(1535, 14314, -190),
		Vector(1427, 14313, -187),
		Vector(1425, 14230, -179),
		Vector(1527, 14227, -183),
		Vector(1531, 14143, -172),
		Vector(1441, 14139, -171),
		Vector(1439, 14059, -168),
		Vector(1542, 14010, -176),
	}

	gm.DefaultSpawnLocation = Vector(-1485, -11828, -412)

	gm.CurrentLocation = LOCATION_CROSSROADS;
end)
