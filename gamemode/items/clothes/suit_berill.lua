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
ITEM.License = "S"
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.RepairCost = 20
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
	[DMG_CRUSH] = .41,
	[DMG_FALL] = .41,
	[DMG_CLUB] = .41,
	[DMG_VEHICLE] = .41,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .41,
	-- "Bulletproof"
	[DMG_BULLET] = .79,
	-- "Explosion"
	[DMG_BLAST] = .79,
	-- "Thermal"
	[DMG_BURN] = .73,
	[DMG_SLOWBURN] = .73,
	-- "Chemical Burn"
	[DMG_ACID] = .88,
	[DMG_POISON] = .88,
	[DMG_NERVEGAS] = .88,
	-- "Electric Shock"
	[DMG_SHOCK] = .88,
	-- "Radiation"
	[DMG_RADIATION] = .94,
	-- "Psychic"
	[DMG_PARALYZE] = 1.00,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 85