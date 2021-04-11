ITEM.Base = "clothes"
ITEM.Name =  "Exoskeleton";
ITEM.Desc =  "A combat exoskeleton developed within the Zone. When the project was canceled, the blueprints found their way to the black market.";
ITEM.Model =  "models/tnb/stalker/items/exo.mdl";
ITEM.Weight =  25;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.CarryAdd =  15;
ITEM.Bonemerge = "models/stalker_2019/exosuit.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 1250000
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
	SuitClass = "suit_exo_lone0",
}
ITEM.HandsModel = {
	body = "100000000",
	model = "models/poc/stalker_viewmodels/c_exorad.mdl",
	skin = 0,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .21,
	[DMG_FALL] = .21,
	[DMG_CLUB] = .21,
	[DMG_VEHICLE] = .21,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .21,
	-- "Bulletproof"
	[DMG_BULLET] = .45,
	-- "Explosion"
	[DMG_BLAST] = .40,
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
	[DMG_RADIATION] = .65,
	-- "Psychic"
	[DMG_PARALYZE] = .60,
}