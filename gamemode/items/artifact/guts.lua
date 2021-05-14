ITEM.Base = "artifact"
ITEM.Name =  "Guts"
ITEM.Desc =  "A semi-organic amalgam of tissue and debris. Stalkers tell stories about them being the remains of victims from the first CNPP meltdowns. Somehow, it's useful in absorbing supersonic shock waves."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/stone flower.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/kali/miscstuff/stalker/artifacts/stone_flower_outer_c"},
{ 1 , "models/props_lab/cornerunit_cloud"}
}

ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  40000
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
    [DMG_BLAST] = 0.6,
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
