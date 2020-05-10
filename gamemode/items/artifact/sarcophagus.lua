
ITEM.Base = "artifact"
ITEM.Name =  "Sarcophagus"
ITEM.Desc =  "An ecologist's lunchbox. Green light seeps through from inside, but you cannot open it. EXTREMELY RADIOACTIVE."
ITEM.Model =  "models/instrument.mdl"
ITEM.Tier =  2
ITEM.Weight =  3;
ITEM.BulkPrice =  50000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1.2,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1.6,
    -- "Thermal"
    [DMG_BURN] = 1.5,
    [DMG_SLOWBURN] = 1.2,
    -- "Chemical Burn"
    [DMG_ACID] = 0.8,
    [DMG_POISON] = 0.7,
    [DMG_NERVEGAS] = 0.8,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 0.8,
    -- "Psychic"
    [DMG_PARALYZE] = 0.6,
}
