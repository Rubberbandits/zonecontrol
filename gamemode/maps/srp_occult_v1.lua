function GM:GetHL2CamPos()
	
	return { Vector( 458, 3100, 635 ), Angle( -11, -82, 0 ) };
	
end

GM.EnableAreaportals = true;

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( 619, 2398, 832 ), Vector( 679, 2194, 832 ) }, { Angle( -26, 17, 0 ), Angle( -24, 12, 0 ) } };
GM.IntroCamData[2] = { { Vector( 2258, 1869, 728 ), Vector( 2476, 1896, 727 ) }, { Angle( -5, 107, 0 ), Angle( 1, 73, 0 ) } };
GM.IntroCamData[3] = { { Vector( 830, 1571, 627 ), Vector( 1029, 1798, 627 ) }, { Angle( -22, -35, 0 ), Angle( -43, -46, 0 ) } };
GM.IntroCamData[4] = { { Vector( 7116, 892, 292 ), Vector( 7297, 894, 276 ) }, { Angle( 7, 1, 0 ), Angle( -4, 1, 0 ) } };
GM.IntroCamData[5] = { { Vector( 6136, 199, 547 ), Vector( 6158, -25, 552 ) }, { Angle( -4, -157, 0 ), Angle( -3, -172, 0 ) } };
GM.IntroCamData[6] = { { Vector( 1041, 2727, 982 ), Vector( 453, 2728, 953 ) }, { Angle( 11, -110, 0 ), Angle( 26, -87, 0 ) } };

GM.CurrentLocation = LOCATION_CITY;

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector( 12074, 866, 284 ), LOCATION_CANAL, 200, TRANSITPORT_CITY_GATE );
	--self:CreateLocationPoint( Vector( 871, 2551, 340 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER );
	--self:CreateLocationPoint( Vector( 2012, 1583, 1236 ), LOCATION_CANAL, 200, TRANSITPORT_CITY_COMBINE );
	
end
--[[
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Behind this door is unguarded - it seems like the Combine haven't noticed yet. There's an entranceway to a small concrete maintenance area.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The sewage pipe looks like you can climb through it. Down a ways, you see a light - it looks like it leads into a concrete maintenance area.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter is here, ready to take you to patrol Sector 12.";

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 11679, 649, 263 ),
	Vector( 11619, 646, 252 ),
	Vector( 11620, 729, 251 ),
	Vector( 11673, 729, 251 ),
	Vector( 11674, 803, 249 ),
	Vector( 11611, 803, 251 ),
};
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( 1040, 2490, 292 ),
	Vector( 1061, 2545, 276 ),
	Vector( 1109, 2486, 292 ),
	Vector( 1128, 2545, 276 ),
	Vector( 1166, 2489, 292 ),
	Vector( 1200, 2544, 276 ),
};
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( 1747, 1634, 1172 ),
	Vector( 1740, 1564, 1172 ),
	Vector( 1741, 1494, 1172 ),
	Vector( 1685, 1457, 1172 ),
	Vector( 1680, 1561, 1172 ),
};
--]]
--[[ GM.EntNamesToRemove = {
	"ambient_generic",
}; ]]

GM.EntPositionsToRemove = {
	Vector( "1862 933.5 2946.26" ),
	Vector( "1818 846 2949" ),
	Vector( "2264.4 3224.52 975.4" )
}

