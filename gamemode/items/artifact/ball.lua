ITEM.Base = "artifact"
ITEM.Name =  "Ball"
ITEM.Desc =  "An agile and bouncy artifact. Not much data on it's formation, but, is known to be found in places of electrical activity. It has no useful properties, but is not radioactive."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/flame.mdl"

ITEM.ItemSubmaterials = {
	{ 0 , "models/shadertest/predator" },
	{ 1 , "models/tnb/artifacts/jellyfish1" },
	{ 2 , "Models/effects/vol_light001" }
}

ITEM.Tier =  1
ITEM.Weight =  0.50;
ITEM.BulkPrice =  4000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}