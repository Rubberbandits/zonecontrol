function GM:GetHL2CamPos()
	
	return { Vector( -929.764893, -9812.979492, 718.457886 ), Angle( 13.711527, 42.577480, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( -13051.937500, -8850.031250, 118.061867 ), LOCATION_GARBAGE, 200, TRANSITPORT_ROSTOK_GARBAGE );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_ROSTOK_GARBAGE] = "Continuing down this road takes you to the Garbage, an area of forgotten treasures and heaps of trash.";

GM.EntryPortSpawns[TRANSITPORT_GARBAGE_ROSTOK] = {
	Vector(-13183.833008, -9363.562500, 126.480820),
	Vector(-13103.040039, -9422.562500, 126.195290),
	Vector(-13042.379883, -9466.859375, 125.768600),
	Vector(-13087.863281, -9538.037109, 126.222435),
	Vector(-13155.278320, -9496.340820, 126.786240),
	Vector(-13205.105469, -9459.969727, 127.028748),
	Vector(-13163.364258, -9581.646484, 127.012955),
	Vector(-13258.948242, -9542.996094, 127.557472),
};

GM.CurrentLocation = LOCATION_ROSTOK;