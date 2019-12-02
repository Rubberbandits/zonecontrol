ITEM.Base = "clothes"
ITEM.Name =  "Sunrise";
ITEM.Desc =  "A basic protective suit used by rookies and masters alike.";
ITEM.Model =  "models/tnb/stalker/items/sunrise.mdl";
ITEM.Weight =  8;
ITEM.FOV 			= 30;
ITEM.CamPos 		= Vector( 1.58, 0.02, 93.17 );
ITEM.LookAt 		= Vector( 1.6, -0.98, -1.92 );
ITEM.BulkPrice =  90000;
ITEM.License =  LICENSE_BLACK;
ITEM.WearModel = "models/kingston/stalker/suit_sunrise.mdl";
ITEM.ArtifactSlots = 2
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_sunrise_lone0",
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
	[DMG_BULLET] = 0,
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
