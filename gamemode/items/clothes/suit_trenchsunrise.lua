ITEM.Base = "clothes"
ITEM.Name =  "Sunrise with Trenchcoat";
ITEM.Desc =  "A basic protective suit used by rookies and masters alike. Worn with a trenchcoat.";
ITEM.Model =  "models/tnb/stalker/items/sunrise.mdl";
ITEM.Weight =  8;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  245000;
ITEM.License =  "S";
ITEM.Bonemerge = "models/tnb/stalker_2019/sunrise_trench.mdl";
ITEM.DegradationProtection = 97.5
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.RepairCost = 25
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.ArtifactSlots = 2
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_trenchsunrise_lone0_bandit0",
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_trench.mdl",
	skin = 1,
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
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false