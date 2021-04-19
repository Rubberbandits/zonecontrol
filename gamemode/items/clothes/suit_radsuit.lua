ITEM.Base = "clothes"
ITEM.Name =  "Radsuit";
ITEM.Desc =  "A heavy combat suit derived from prototype exoskeleton units. Sacrifices armor for mobility.";
ITEM.Model =  "models/tnb/stalker/items/radsuit.mdl";
ITEM.Weight =  14;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/stalker_2019/radsuit.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 500000
ITEM.License = "S"
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.AllowGender = true
ITEM.ArtifactSlots = 1
ITEM.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "suit_radsuit_lone0",
}
ITEM.HandsModel = {
	body = "010000000",
	model = "models/poc/stalker_viewmodels/c_exorad.mdl",
	skin = 0,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .35,
	[DMG_FALL] = .35,
	[DMG_CLUB] = .35,
	[DMG_VEHICLE] = .35,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .35,
	-- "Bulletproof"
	[DMG_BULLET] = .55,
	-- "Explosion"
	[DMG_BLAST] = .55,
	-- "Thermal"
	[DMG_BURN] = .62,
	[DMG_SLOWBURN] = .62,
	-- "Chemical Burn"
	[DMG_ACID] = .62,
	[DMG_POISON] = .62,
	[DMG_NERVEGAS] = .62,
	-- "Electric Shock"
	[DMG_SHOCK] = .62,
	-- "Radiation"
	[DMG_RADIATION] = .75,
	-- "Psychic"
	[DMG_PARALYZE] = .60,
}
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false