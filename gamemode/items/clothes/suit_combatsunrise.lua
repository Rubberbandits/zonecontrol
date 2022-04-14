ITEM.Base = "clothes"
ITEM.Name =  "Combat Sunrise";
ITEM.Desc =  "An upgraded Sunrise suit incorporating a better mask and helmet.";
ITEM.Model =  "models/tnb/stalker/items/sunrise.mdl";
ITEM.Weight =  8;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/tnb/stalker_2019/sunrise_combat.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 250000
ITEM.License = "S"
ITEM.RemoveBody = true
ITEM.AllowGender = true
ITEM.HelmetBodygroup = {0,1}
ITEM.RepairCost = 22
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
	[DMG_CRUSH] = 0.71,
	[DMG_FALL] = 0.71,
	[DMG_CLUB] = 0.71,
	[DMG_VEHICLE] = 0.71,
	-- "Rupture" (sharp)
	[DMG_SLASH] = 0.8,
	-- "Bulletproof"
	[DMG_BULLET] = 0.81,
	-- "Explosion"
	[DMG_BLAST] = 0.9,
	-- "Thermal"
	[DMG_BURN] = 0.68,
	[DMG_SLOWBURN] = 0.68,
	-- "Chemical Burn"
	[DMG_ACID] = 0.72,
	[DMG_POISON] = 0.72,
	[DMG_NERVEGAS] = 0.72,
	-- "Electric Shock"
	[DMG_SHOCK] = 0.73,
	-- "Radiation"
	[DMG_RADIATION] = 0.78,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 85