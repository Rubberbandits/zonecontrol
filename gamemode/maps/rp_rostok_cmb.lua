function GM:GetHL2CamPos()
	
	return { Vector( -929.764893, -9812.979492, 718.457886 ), Angle( 13.711527, 42.577480, 0.000000 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector( -13051.937500, -8850.031250, 118.061867 ), LOCATION_GARBAGE, 200, TRANSITPORT_ROSTOK_GARBAGE );
	self:CreateLocationPoint( Vector( -3113.026611, -12049.968750, 64.031250 ), LOCATION_TRUCKCEMETERY, 200, TRANSITPORT_ROSTOK_TRUCKCEMETERY );
	
end

GM.EnableAreaportals = true;

GM.ConnectMessages[TRANSITPORT_ROSTOK_GARBAGE] = "Continuing down this road takes you to the Garbage, an area of forgotten treasures and heaps of trash.";
GM.ConnectMessages[TRANSITPORT_ROSTOK_TRUCKCEMETERY] = "Continuing down this road takes you to the Truck Cemetery, where most of vehicles used in the containment of the initial Chernobyl incident ended their lives. Highly dangerous, fortunes are made and lost there."

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
GM.EntryPortSpawns[TRANSITPORT_TRUCKCEMETERY_ROSTOK] = {
	Vector(-3141.553223, -11305.160156, 64.031250),
	Vector(-3076.680664, -11302.453125, 64.031250),
	Vector(-3078.033203, -11247.536133, 64.031250),
	Vector(-3151.978760, -11248.680664, 64.031250),
	Vector(-3156.227783, -11169.300781, 64.031250),
	Vector(-3078.635498, -11164.687500, 64.031250),
	Vector(-3081.602539, -11089.993164, 64.031250),
	Vector(-3146.930664, -11089.606445, 64.031250),
}

GM.DefaultSpawnLocation = Vector(-5507.044922, -10487.567383, 64.031250)

GM.CurrentLocation = LOCATION_ROSTOK;
