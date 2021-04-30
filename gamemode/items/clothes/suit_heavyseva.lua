ITEM.Base = "clothes"
ITEM.Name =  "Heavy SEVA Suit";
ITEM.Desc =  "An advanced stalker suit, manufactured illegally in Kiev specifically for Zone operations. Production was limited to begin with and they're only getting rarer. Upgraded with extra armor.";
ITEM.Model =  "models/tnb/stalker/items/seva.mdl";
ITEM.Weight =  14;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.WearModel = "models/kingston/stalker/suit_seva_armor.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 475000
ITEM.License = "S"
ITEM.ArtifactSlots = 2
ITEM.RepairCost = 36
ITEM.RemoveBody = true
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_heavyseva_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 5,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .45,
	[DMG_FALL] = .45,
	[DMG_CLUB] = .45,
	[DMG_VEHICLE] = .45,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .45,
	-- "Bulletproof"
	[DMG_BULLET] = .69,
	-- "Explosion"
	[DMG_BLAST] = .65,
	-- "Thermal"
	[DMG_BURN] = .30,
	[DMG_SLOWBURN] = .30,
	-- "Chemical Burn"
	[DMG_ACID] = .20,
	[DMG_POISON] = .20,
	[DMG_NERVEGAS] = .20,
	-- "Electric Shock"
	[DMG_SHOCK] = .25,
	-- "Radiation"
	[DMG_RADIATION] = .10,
	-- "Psychic"
	[DMG_PARALYZE] = .39,
}
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 95