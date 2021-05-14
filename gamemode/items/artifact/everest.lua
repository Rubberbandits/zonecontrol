ITEM.Base = "artifact"
ITEM.Name =  "Everest"
ITEM.Desc =  "The bleeding heart of a violent blizzard. Behaving much like dry ice, this artifact is constantly weeping cold, dense mist. Has a large negative temperature exchange impulse. Will render the bare hand frostbitten, hardening skin over time. Users report increased radiation absorption while having it equipped."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/crystal.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/tnb/artifacts/volt2" }
{ 1 , "models/tnb/artifacts/sponge2" }
}

ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  48000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.9,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 0.65,
    [DMG_SLOWBURN] = 0.65,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
