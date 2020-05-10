
ITEM.Base = "artifact"
ITEM.Name =  "Sword"
ITEM.Desc =  "This jealous thing's passion is to poke you -- in fact, so much so, it toughens skin prior to puncture from exterior sources."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/night star.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/kali/miscstuff/stalker/artifacts/night_star_inner_c" },
{ 1 , "models/props_debris/plasterwall039c" }
}

ITEM.Tier =  2
ITEM.Weight =  1;
ITEM.BulkPrice =  7500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .6,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = .7,
    [DMG_POISON] = .7,
    [DMG_NERVEGAS] = .7,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
