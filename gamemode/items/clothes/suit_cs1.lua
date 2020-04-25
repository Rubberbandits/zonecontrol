ITEM.Base = "clothes"
ITEM.Name =  "CS-1";
ITEM.Desc =  "An old suit formerly in service to the Clear Sky faction. Against all odds it's survived to the present day.";
ITEM.Model =  "models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl";
ITEM.Weight =  8;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/stalker_2019/cs1.mdl";
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.ArtifactSlots = 1
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_cs1_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 6,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .29,
	[DMG_FALL] = .29,
	[DMG_CLUB] = .29,
	[DMG_VEHICLE] = .29,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .29,
	-- "Bulletproof"
	[DMG_BULLET] = .59,
	-- "Explosion"
	[DMG_BLAST] = .59,
	-- "Thermal"
	[DMG_BURN] = .62,
	[DMG_SLOWBURN] = .62,
	-- "Chemical Burn"
	[DMG_ACID] = .82,
	[DMG_POISON] = .82,
	[DMG_NERVEGAS] = .82,
	-- "Electric Shock"
	[DMG_SHOCK] = .73,
	-- "Radiation"
	[DMG_RADIATION] = .88,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}