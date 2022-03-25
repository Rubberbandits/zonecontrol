ITEM.Base = "clothes"
ITEM.Name =  "SEVA Suit";
ITEM.Desc =  "An advanced stalker suit, manufactured illegally in Kiev specifically for Zone operations. Production was limited to begin with and they're only getting rarer.";
ITEM.Model =  "models/tnb/stalker/items/seva.mdl";
ITEM.Weight =  10;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  400000;
ITEM.License =  "S";
ITEM.Bonemerge = "models/tnb/stalker_2019/seva.mdl";
ITEM.DegradationProtection = 97.5
ITEM.RepairCost = 30
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.ArtifactSlots = 2
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_seva_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 5,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = 0.50,
	[DMG_FALL] = 0.50,
	[DMG_CLUB] = 0.50,
	[DMG_VEHICLE] = 0.50,
	-- "Rupture" (sharp)
	[DMG_SLASH] = 0.50,
	-- "Bulletproof"
	[DMG_BULLET] = 0.89,
	-- "Explosion"
	[DMG_BLAST] = 0.85,
	-- "Thermal"
	[DMG_BURN] = 0.30,
	[DMG_SLOWBURN] = 0.30,
	-- "Chemical Burn"
	[DMG_ACID] = 0.20,
	[DMG_POISON] = 0.20,
	[DMG_NERVEGAS] = 0.20,
	-- "Electric Shock"
	[DMG_SHOCK] = 0.25,
	-- "Radiation"
	[DMG_RADIATION] = 0.10,
	-- "Psychic"
	[DMG_PARALYZE] = 0.39,
}
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 90