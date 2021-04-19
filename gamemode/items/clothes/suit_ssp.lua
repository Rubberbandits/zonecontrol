ITEM.Base = "clothes"
ITEM.Name =  "SSP-99";
ITEM.Desc =  "An advanced scientific suit designed for ecological work within the Exclusion Zone.";
ITEM.Model =  "models/kek1ch/ecolog_outfit_green.mdl";
ITEM.Weight =  12;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/tnb/stalker_2019/ssp.mdl";
ITEM.DegradationProtection = 97.5
ITEM.BulkPrice = 500000
ITEM.License = "S"
ITEM.Bodygroups = {
	{1, 0}
}
ITEM.RemoveBody = true
ITEM.HelmetBodygroup = {1,1}
ITEM.ScaleForGender = 0.8
ITEM.NoVariants = true
ITEM.ArtifactSlots = 3
ITEM.Submaterials = {
	{ 0 , "models/kingstonstalker/ssp_suit/ssp_eco0" }
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_ssp.mdl",
	skin = 1,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .80,
	[DMG_FALL] = .80,
	[DMG_CLUB] = .80,
	[DMG_VEHICLE] = .80,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .85,
	-- "Bulletproof"
	[DMG_BULLET] = 1.00,
	-- "Explosion"
	[DMG_BLAST] = .85,
	-- "Thermal"
	[DMG_BURN] = .10,
	[DMG_SLOWBURN] = .10,
	-- "Chemical Burn"
	[DMG_ACID] = .10,
	[DMG_POISON] = .10,
	[DMG_NERVEGAS] = .10,
	-- "Electric Shock"
	[DMG_SHOCK] = .10,
	-- "Radiation"
	[DMG_RADIATION] = .10,
	-- "Psychic"
	[DMG_PARALYZE] = .10,
}
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false