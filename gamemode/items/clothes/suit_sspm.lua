ITEM.Base = "clothes"
ITEM.Name =  "SSP-99M";
ITEM.Desc =  "An advanced scientific suit designed for ecological work within the Exclusion Zone. Upgraded with kevlar padding for emergency protection.";
ITEM.Model =  "models/kek1ch/ecolog_outfit_orange.mdl";
ITEM.Weight =  12;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Bonemerge = "models/tnb/stalker_2019/ssp.mdl";
ITEM.DegradationProtection = 25
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
	{ 0 , "models/kingstonstalker/ssp_suit/ssp_eco1" }
}
ITEM.HandsModel = {
	body = "000000000",
	model = "models/poc/stalker_viewmodels/c_ssp.mdl",
	skin = 0,
}

ITEM.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .60,
	[DMG_FALL] = .60,
	[DMG_CLUB] = .60,
	[DMG_VEHICLE] = .60,
	-- "Rupture" (sharp)
	[DMG_SLASH] = .65,
	-- "Bulletproof"
	[DMG_BULLET] = .80,
	-- "Explosion"
	[DMG_BLAST] = .75,
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