ITEM.Base = "clothes"
ITEM.Name =  "Berill-5M";
ITEM.Desc =  "A military combat suit adapted from regular military gear.";
ITEM.Model =  "models/tnb/stalker/items/berill.mdl";
ITEM.Weight =  10;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/stalker_2019/berill.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 400000
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.RepairCost = 27
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_berill_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 4,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = 0.41,
	[DMG_FALL] = 0.41,
	[DMG_CLUB] = 0.41,
	[DMG_VEHICLE] = 0.41,
	-- "Rupture" (sharp)
	[DMG_SLASH] = 0.41,
	-- "Bulletproof"
	[DMG_BULLET] = 0.79,
	-- "Explosion"
	[DMG_BLAST] = 0.79,
	-- "Thermal"
	[DMG_BURN] = 0.73,
	[DMG_SLOWBURN] = 0.73,
	-- "Chemical Burn"
	[DMG_ACID] = 0.88,
	[DMG_POISON] = 0.88,
	[DMG_NERVEGAS] = 0.88,
	-- "Electric Shock"
	[DMG_SHOCK] = 0.88,
	-- "Radiation"
	[DMG_RADIATION] = 0.94,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 85