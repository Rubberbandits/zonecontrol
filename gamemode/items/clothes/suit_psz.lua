ITEM.Base = "clothes"
ITEM.Name =  "PS5-M Universal Protection";
ITEM.Desc =  "Essentially a SEVA suit permanently stripped of its advanced life support equipment.";
ITEM.Model =  "models/tnb/stalker/items/sunrise.mdl";
ITEM.Weight =  8;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  90000;
ITEM.License =  "X";
ITEM.Bonemerge = "models/stalker_2019/psz.mdl";
ITEM.DegradationProtection = 90
ITEM.BulkPrice = 245000
ITEM.License = "S"
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
	SuitClass = "suit_psz_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 5,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .71,
	[DMG_FALL] = .71,
	[DMG_CLUB] = .71,
	[DMG_VEHICLE] = .71,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .8,
	-- "Bulletproof"
	[DMG_BULLET] = .91,
	-- "Explosion"
	[DMG_BLAST] = .9,
	-- "Thermal"
	[DMG_BURN] = .68,
	[DMG_SLOWBURN] = .68,
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