function GM:GetHL2CamPos()
	
	return { Vector( -660, 1152, 708 ), Angle( 21, 110, 0 ) };
	
end

function GM:GetCombineCratePos()
	return { Vector( -295, 808, 153 ), Angle( 1, -89, -0 ) };	
end

function GM:GetCombineRationPos()
	
	return { Vector( 1405, 1261, 566 ), Angle( 0, -90, 0 ) };
	
end

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( 1195, -2404, 926 ), Vector( 1193, -2599, 934 ) }, { Angle( -3, -48, 0 ), Angle( -0, -36, 0 ) } };
GM.IntroCamData[2] = { { Vector( -525, -816, 893 ), Vector( -219, -607, 897 ) }, { Angle( 1, 130, 0 ), Angle( 5, 143, 0 ) } };
GM.IntroCamData[3] = { { Vector( 1872, -741, 594 ), Vector( 2105, -743, 590 ) }, { Angle( 4, 51, 0 ), Angle( 3, 96, 0 ) } };
GM.IntroCamData[4] = { { Vector( -1058, 3942, 1003 ), Vector( -1031, 4367, 994 ) }, { Angle( 1, 103, 0 ), Angle( 3, 42, 0 ) } };
GM.IntroCamData[5] = { { Vector( -1215, 373, 1597 ), Vector( -1088, -579, 1537 ) }, { Angle( 4, -57, 0 ), Angle( 4, 1, 0 ) } };
GM.IntroCamData[6] = { { Vector( 3798, -176, 864 ), Vector( 3899, 141, 947 ) }, { Angle( -36, 118, 0 ), Angle( -45, 149, 0 ) } };

GM.CurrentLocation = LOCATION_CITY;


GM.Stoves = {

};

GM.CombineSpawnpoints = {
Vector( 309, 1909, -311 ),

};

GM.DoorData = {

{ 2838, DOOR_COMBINEOPEN, "Overwatch Nexus" },
{ 2580, DOOR_COMBINEOPEN, "Overwatch Nexus" },
{ 2523, DOOR_COMBINEOPEN, "Overwatch Nexus" },
{ 2466, DOOR_COMBINEOPEN, "Overwatch Nexus" },
{ 1737, DOOR_COMBINELOCK, "Holding Cell 1" },
{ 1738, DOOR_COMBINELOCK, "Holding Cell 2" },
{ 2072, DOOR_COMBINELOCK, "Isolation Cell" },
{ 1715, DOOR_UNBUYABLE, "Civil Housing" },
{ 1685, DOOR_BUYABLE, "Cafe", 20, "Cafe" },
{ 2425, DOOR_UNBUYABLE, "Apartment", "Cafe" },
{ 2390, DOOR_BUYABLE, "Shop", 20, "Shop_1" },
{ 2391, DOOR_UNBUYABLE, "Stock Room", "Shop_1" },
{ 2013, DOOR_BUYABLE, "Gentleman's Club", 30, "Club" },
{ 2014, DOOR_BUYABLE, "Gentleman's Club", 30, "Club" },
{ 2686, DOOR_BUYABLE, "Hospital", 20, "Hospital" },
{ 2696, DOOR_BUYABLE, "Hospital", 20, "Hospital" },
{ 2695, DOOR_UNBUYABLE, "Inpatient Care", "Hospital" },
{ 1801, DOOR_COMBINELOCK, "Civic Center", "Admin" },
{ 1802, DOOR_COMBINELOCK, "Civic Center", "Admin" },
{ 1908, DOOR_COMBINELOCK, "Civic Center", "Admin" },
{ 1938, DOOR_COMBINELOCK, "Office 101", "Admin" },
{ 1939, DOOR_COMBINELOCK, "Office 102", "Admin" },
{ 3053, DOOR_COMBINELOCK, "Office 201", "Admin" },
{ 3054, DOOR_COMBINELOCK, "Office 202", "Admin" },
{ 3055, DOOR_COMBINELOCK, "Office 203", "Admin" },
{ 3056, DOOR_COMBINELOCK, "Office 204", "Admin" },
{ 3347, DOOR_COMBINELOCK, "Library", "Admin" },
{ 1814, DOOR_COMBINELOCK, "Lecture Hall", "Admin" },
{ 1815, DOOR_COMBINELOCK, "Services", "Admin" },

};