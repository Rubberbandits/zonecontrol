ITEM.Base = "artifact"
ITEM.Name =  "Crystal"
ITEM.Desc =  "This artifact is formed in anomalous zones with intense thermal activity. Actively consumes excessive heat, remaining cool to the touch throughout. Seems to make the user susceptible to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/crystal.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.50
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
    [DMG_BURN] = 0.7,
    [DMG_SLOWBURN] = 0.7,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
