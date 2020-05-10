
ITEM.Base = "artifact"
ITEM.Name =  "Stone Flower"
ITEM.Desc =  "A porous geode with large, irregular perforations spread across it. From within shimmers turquoise liquid crystals. A visible haze of energy resolves around it and disperses continuously. Hardens the skin and lends the wielder strength. Emits radiation."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/stone flower.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
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
    [DMG_BULLET] = .95,
    -- "Explosion"
    [DMG_BLAST] = .95,
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
    [DMG_RADIATION] = 1.05,
    -- "Psychic"
    [DMG_PARALYZE] = .95,
}
