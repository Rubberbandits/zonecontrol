ITEM.Base = "artifact"
ITEM.Name =  "Stone Flower"
ITEM.Desc =  "A porous geode with large, irregular perforations spread across it. From within shimmers turquoise liquid crystals. A visible haze of energy resolves around it and disperses continuously. Soothes the mind in times of duress. Slightly conductive to radiation."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/stone flower.mdl"
ITEM.ItemSubmaterials = {
{ 1 , "models/tnb/artifacts/sparkler2" }
}

ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice =  7500
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
    [DMG_RADIATION] = 1.1,
    -- "Psychic"
    [DMG_PARALYZE] = 0.7,
}