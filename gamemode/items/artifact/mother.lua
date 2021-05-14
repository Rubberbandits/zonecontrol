ITEM.Base = "artifact"
ITEM.Name =  "Mother"
ITEM.Desc =  "A familiar miniature. It is unknown where such an intriguing artifact might have formed. It is widely speculated and deeply feared that there aren't many duplicates out there. Those who wield it tend to experience increased skin elasticity and clearer, sounder thoughts, along with slight resistance to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/urchin.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/tnb/artifacts/flash1" }
}

ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  25000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.85,
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
    [DMG_RADIATION] = 0.85,
    -- "Psychic"
    [DMG_PARALYZE] = 0.85,
}