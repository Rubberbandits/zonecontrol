ITEM.Base = "clothes"
ITEM.Name =  "IO7a with Trenchcoat";
ITEM.Desc =  "A basic combat suit favored by mercenaries.";
ITEM.Model =  "models/tnb/stalker/items/io7a.mdl";
ITEM.Weight =  7;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  110000;
ITEM.License =  "S";
ITEM.Bonemerge = "models/tnb/stalker_2019/io7a_trench.mdl";
ITEM.DegradationProtection = 97.5
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_trenchio7_lone0_bandit0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_trench.mdl",
	skin = 1,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .85,
	[DMG_FALL] = .85,
	[DMG_CLUB] = .85,
	[DMG_VEHICLE] = .85,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .75,
	-- "Bulletproof"
	[DMG_BULLET] = .75,
	-- "Explosion"
	[DMG_BLAST] = .75,
	-- "Thermal"
	[DMG_BURN] = .85,
	[DMG_SLOWBURN] = .85,
	-- "Chemical Burn"
	[DMG_ACID] = .85,
	[DMG_POISON] = .85,
	[DMG_NERVEGAS] = .85,
	-- "Electric Shock"
	[DMG_SHOCK] = .90,
	-- "Radiation"
	[DMG_RADIATION] = .88,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}