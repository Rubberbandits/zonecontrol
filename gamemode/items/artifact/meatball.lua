ITEM.Base = "artifact"
ITEM.Name =  "Meatball"
ITEM.Desc =  "An immaculately polished ball bearing encapsulated by unnatural muscle mass. Rumoured to be the result of gross lab experiments with bioengineered cells from Flesh, it can be felt tensing and relaxing in the hand. Known for its radiation reducing qualities."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/flame.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/barnacle/roots" },
{ 1 , "debug/env_cubemap_model" }
}

ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  20000
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
    [DMG_RADIATION] = 0.75,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
