ITEM.Base = "artifact"
ITEM.Name =  "Cocoon"
ITEM.Desc =  "A formation of gravitational nature. It has no useful properties, but is not radioactive and is sought after by merchants and jewellers."
ITEM.Model =  "models/tnb/stalker/artifacts/wrenched.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/tnb/artifacts/volt1" }
}

ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  18000
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