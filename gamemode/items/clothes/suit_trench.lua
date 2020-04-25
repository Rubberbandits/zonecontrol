ITEM.Base = "clothes"
ITEM.Name =  "Trenchcoat";
ITEM.Desc =  "A simple leather trenchcoat. Commonly associated with people of ill repute.";
ITEM.Model =  "models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl";
ITEM.Weight =  4;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  10000;
ITEM.License =  LICENSE_BLACK;
ITEM.Bonemerge = "models/tnb/stalker_2019/trenchcoat_io7mask.mdl";
ITEM.Bodygroups = {
	{0, 1}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {0,0}
ITEM.ScaleForGender = 0.8
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_trench_bandit0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_trench.mdl",
	skin = 1,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .79,
	[DMG_FALL] = .79,
	[DMG_CLUB] = .79,
	[DMG_VEHICLE] = .79,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .8,
	-- "Bulletproof"
	[DMG_BULLET] = .94,
	-- "Explosion"
	[DMG_BLAST] = 1,
	-- "Thermal"
	[DMG_BURN] = .88,
	[DMG_SLOWBURN] = .88,
	-- "Chemical Burn"
	[DMG_ACID] = .94,
	[DMG_POISON] = .94,
	[DMG_NERVEGAS] = .94,
	-- "Electric Shock"
	[DMG_SHOCK] = 1,
	-- "Radiation"
	[DMG_RADIATION] = 1,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}