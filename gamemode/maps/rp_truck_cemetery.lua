function GM:GetHL2CamPos()
	
	return { Vector( 5098.854980, 5456.890625, 959.771790 ), Angle( 18.265495, -127.256851, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( 8175.968750, 6422.540039, -2.207825 ), LOCATION_ROSTOK, 200, TRANSITPORT_TRUCKCEMETERY_ROSTOK );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_TRUCKCEMETERY_ROSTOK] = "Continuing down this road takes you to Rostok, the location of the famous 100 Rads Bar, though newly controlled by Freedom.";

GM.EntryPortSpawns[TRANSITPORT_ROSTOK_TRUCKCEMETERY] = {
	Vector(7470.789551, 6226.573242, -16.720093),
	Vector(7458.537598, 6333.931641, -25.106644),
	Vector(7450.048828, 6431.096191, -26.848358),
	Vector(7338.888184, 6425.815918, -32.403351),
	Vector(7342.473145, 6354.098633, -31.624733),
	Vector(7350.162109, 6266.092285, -25.605995),
	Vector(7227.900391, 6285.977539, -37.727448),
	Vector(7220.001953, 6373.568359, -41.735260),
};

GM.CurrentLocation = LOCATION_TRUCKCEMETERY;
