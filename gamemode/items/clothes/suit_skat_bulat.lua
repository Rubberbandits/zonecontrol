ITEM.Base = "clothes"
ITEM.Name =  "SKAT-9 Bulat";
ITEM.Desc =  "A military combat suit designed specially for Exclusion Zone operations. Good blend of mobility and armor.";
ITEM.Model =  "models/tnb/stalker/items/skat.mdl";
ITEM.Weight =  12;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/tnb/stalker_2019/skat9_bulat.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 625000
ITEM.License = "S"
ITEM.RepairCost = 45
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
	SuitClass = "suit_skat_bulat_lone0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 4,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .29,
	[DMG_FALL] = .29,
	[DMG_CLUB] = .29,
	[DMG_VEHICLE] = .29,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .29,
	-- "Bulletproof"
	[DMG_BULLET] = .59,
	-- "Explosion"
	[DMG_BLAST] = .59,
	-- "Thermal"
	[DMG_BURN] = .62,
	[DMG_SLOWBURN] = .62,
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
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false
ITEM.SelfRepairCondition = 95