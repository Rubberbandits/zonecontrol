ITEM.Base = "clothes"
ITEM.Name =  "Combat Sunrise";
ITEM.Desc =  "An upgraded Sunrise suit incorporating a better mask and helmet.";
ITEM.Model =  "models/tnb/stalker/items/sunrise.mdl";
ITEM.Weight =  8;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/tnb/stalker_2019/sunrise_combat.mdl";
ITEM.DegradationProtection = 90
ITEM.RemoveBody = true
ITEM.AllowGender = true
ITEM.HelmetBodygroup = {0,1}
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_combatsunrise_lone10",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 0,
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
	[DMG_BULLET] = .81,
	-- "Explosion"
	[DMG_BLAST] = .9,
	-- "Thermal"
	[DMG_BURN] = .68,
	[DMG_SLOWBURN] = .68,
	-- "Chemical Burn"
	[DMG_ACID] = .72,
	[DMG_POISON] = .72,
	[DMG_NERVEGAS] = .72,
	-- "Electric Shock"
	[DMG_SHOCK] = .73,
	-- "Radiation"
	[DMG_RADIATION] = .78,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}
